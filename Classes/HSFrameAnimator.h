//
//  HSFrameAnimator.h
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

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
  HSAnimationModeLoop, HSAnimationModeOnce
} HSAnimationMode;

@interface HSFrameAnimator : NSObject {
 @private
  long spriteCounter_;
  float framerate_;
  NSTimer *timer_;

  NSMutableDictionary *sprites_;
  NSMutableDictionary *textures_;
  NSMutableArray *spritesFinishedAnimating_;
  
  id callback_;
  SEL callbackSelector_;
}

@property (nonatomic, assign) float framerate;
@property (nonatomic, retain) id callback;

- (id)init;

// Adds an NSArray of UIImages with an identifying key
- (void)addFrameset:(NSArray*)frameset forKey:(NSString*)key;

// Removes a frameset previously registered with a specific key
- (void)removeFramesetWithKey:(NSString*)key;

// Adds a sprite to animate for a certain frameset
- (void)registerSprite:(CALayer*)sprite forFrameset:(NSString*)frameset;
- (void)registerSprite:(CALayer*)sprite forFrameset:(NSString*)frameset andAnimationMode:(HSAnimationMode)animationMode;

// Removes any references from this animator to a sprite
- (void)deregisterSprite:(CALayer*)sprite;

// Starts the animating timer
- (void)startTimer;

// Stops the animating timer
- (void)stopTimer;

@end
