//
//  HSFrameAnimator.m
//  SpriteAnimationFramework
//
//  Created by Hans Sjunnesson on 2009-03-28.
//  Copyright 2009 Hans Sjunnesson. All rights reserved.
//

#import "HSFrameAnimator.h"


@implementation HSFrameAnimator

@synthesize framerate = framerate_;

- (id)init {
  if (self = [super init]) {
    framerate_ = 1.0/25.0;

    sprites_ =  [[NSMutableArray alloc] init];
    textures_ = [[NSMutableDictionary alloc] init];

    framesetsForSprites_ = [[NSMutableDictionary alloc] init];
    currentFramesForSprites_ = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

- (void)dealloc {
  [self stopTimer];
  [sprites_ release];
  
  [textures_ release];
  [super dealloc];
}

- (void)addFrameset:(NSArray*)frameset forKey:(NSString*)key {
  [textures_ setObject:frameset forKey:key];
}

- (void)removeFramesetWithKey:(NSString*)key {
  [textures_ removeObjectForKey:key];
}

- (void)registerSprite:(CALayer*)sprite forFrameset:(NSString*)frameset {
  if (![sprites_ containsObject:sprite]) {
    [sprites_ addObject:sprite];
  }

  // Start on first frame of the frameset
  NSNumber *index = [NSNumber numberWithInt:[sprites_ indexOfObject:sprite]];
  [currentFramesForSprites_ setObject:[NSNumber numberWithInt:0] forKey:index];

  [framesetsForSprites_ setObject:frameset forKey:index];
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

  for (CALayer *sprite in sprites_)
  {
    int index = [sprites_ indexOfObject:sprite];
    NSNumber *indexNumber = [NSNumber numberWithInt:index];

    NSString *frameset = [framesetsForSprites_ objectForKey:indexNumber];
    NSArray *textures = [textures_ objectForKey:frameset];

    NSNumber *currentframe = [currentFramesForSprites_ objectForKey:indexNumber];
    UIImage *image = [textures objectAtIndex:[currentframe intValue]];
    
    [sprite setContents:(id)image.CGImage];
    
    int newCurrentFrame = [currentframe intValue];
    newCurrentFrame++;
    
    if (newCurrentFrame > [textures count]-1)
      newCurrentFrame = 0;
    [currentFramesForSprites_ setObject:[NSNumber numberWithInt:newCurrentFrame] forKey:indexNumber];
  }

  [CATransaction commit];
}

@end
