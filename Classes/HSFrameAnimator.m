//
//  HSFrameAnimator.m
//  SpriteAnimationFramework
//
//  Created by Hans Sjunnesson (hans.sjunnesson@gmail.com) on 2009-03-28.
//  Copyright 2009 Hans Sjunnesson. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import "HSFrameAnimator.h"
#import "HSSprite.h"

@implementation HSFrameAnimator

@synthesize framerate = framerate_;
@synthesize callback = callback_;

- (id)init {
  if (self = [super init]) {
    framerate_ = 1.0/25.0;
    spriteCounter_ = 0;
    
    sprites_ =  [[NSMutableDictionary alloc] init];
    textures_ = [[NSMutableDictionary alloc] init];
    
    callbackSelector_ = @selector(hasFinishedAnimatingSprite:forFrameset:);
    
    spritesFinishedAnimating_ = [[NSMutableArray alloc] init];
  }
  
  return self;
}

- (void)dealloc {
  [self stopTimer];
  [sprites_ release];
  [textures_ release];
  [spritesFinishedAnimating_ release];
  
  if (callback_)
    [callback_ release];
  
  [super dealloc];
}

- (void)addFrameset:(NSArray*)frameset forKey:(NSString*)key {
  [textures_ setObject:frameset forKey:key];
}

- (void)removeFramesetWithKey:(NSString*)key {
  [textures_ removeObjectForKey:key];
}

- (void)registerSprite:(CALayer*)sprite forFrameset:(NSString*)frameset {
  [self registerSprite:sprite forFrameset:frameset andAnimationMode:HSAnimationModeLoop];
}

- (void)registerSprite:(CALayer*)sprite forFrameset:(NSString*)frameset andAnimationMode:(HSAnimationMode)animationMode {
  NSNumber *index;
  bool found = false;
  HSSprite *theSprite;
  
  for (NSNumber *key in sprites_) {
    theSprite = [sprites_ objectForKey:key];
    if (theSprite.sprite == sprite)
    {
      index = key;
      found = true;
      theSprite = [sprites_ objectForKey:key];
      break;
    }
  }
  
  if (!found) {
    index = [NSNumber numberWithLong:spriteCounter_++];
    theSprite = [[[HSSprite alloc] init] autorelease];
    [theSprite setSprite:sprite];
    [sprites_ setObject:theSprite forKey:index];
  }
  
  // Start on first frame of the frameset
  [theSprite setFrameset:frameset];
  [theSprite setFrame:0];
  [theSprite setAnimationMode:animationMode];
}

- (void)deregisterSprite:(CALayer*)sprite {
  HSSprite *theSprite;
  
  for (NSNumber *key in sprites_) {
    theSprite = [sprites_ objectForKey:key];
    if (theSprite.sprite == sprite) {
      [sprites_ removeObjectForKey:key];
      break;
    }
  }
}

- (void)startTimer {
  if (timer_)
    [self stopTimer];
  
  timer_ = [NSTimer timerWithTimeInterval:framerate_ target:self selector:@selector(advanceFrame) userInfo:nil repeats:YES];
  [[NSRunLoop currentRunLoop] addTimer:timer_  forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer {
  if (timer_) {
    [timer_ invalidate];
    timer_ = nil;
  }
}

@end

@implementation HSFrameAnimator (private)

- (void)advanceFrame {
  [CATransaction begin]; 
  [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];

  for (NSNumber *key in sprites_)
  {
    HSSprite *theSprite = [sprites_ objectForKey:key];
    CALayer *sprite = theSprite.sprite;
    NSString *frameset = theSprite.frameset;
    NSArray *textures = [textures_ objectForKey:frameset];
    int currentframe = theSprite.frame;
    UIImage *image = [textures objectAtIndex:[theSprite frame]];
    
    [sprite setContents:(id)image.CGImage];

    currentframe++;
    
    if (currentframe > [textures count]-1)
    {
      // Last frame on a loop, reset to first frame
      if (theSprite.animationMode == HSAnimationModeLoop)
      {
        currentframe = 0;
      }
      
      // Finished animating, deregister and callback
      if (theSprite.animationMode == HSAnimationModeOnce)
      {
        [spritesFinishedAnimating_ addObject:theSprite];
      }
    }
    
    theSprite.frame = currentframe;
  }
  
  [CATransaction commit];
  
  for (HSSprite *sprite in spritesFinishedAnimating_) {
    [sprite retain];
    [self deregisterSprite:sprite.sprite];

    if (callback_)
    {
      @try {
        [callback_ performSelector:callbackSelector_ withObject:sprite.sprite withObject:sprite.frameset];
      }
      @catch (NSException *e) {
        NSLog(@"Caught exception %@: %@", [e name], [e reason]);
      }
    }
    [sprite release];
  }
  
  [spritesFinishedAnimating_ removeAllObjects];
}

@end
