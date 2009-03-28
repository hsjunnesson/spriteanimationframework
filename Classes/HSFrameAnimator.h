//
//  HSFrameAnimator.h
//  SpriteAnimationFramework
//
//  Created by Hans Sjunnesson on 2009-03-28.
//  Copyright 2009 Hans Sjunnesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface HSFrameAnimator : NSObject {
 @private
  float framerate_;
  NSTimer *timer_;

  NSMutableArray *sprites_;
  NSMutableDictionary *textures_;

  NSMutableDictionary *currentFramesForSprites_;
  NSMutableDictionary *framesetsForSprites_;
}

@property (nonatomic, assign) float framerate;

- (id)init;

// Adds an NSArray of UIImages with an identifying key
- (void)addFrameset:(NSArray*)frameset forKey:(NSString*)key;

// Removes a frameset previously registered with a specific key
- (void)removeFramesetWithKey:(NSString*)key;

- (void)registerSprite:(CALayer*)sprite forFrameset:(NSString*)frameset;

// Starts the animating timer
- (void)startTimer;

// Stops the animating timer
- (void)stopTimer;

@end
