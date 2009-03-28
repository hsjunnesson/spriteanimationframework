//
//  SpriteAnimationFrameworkAppDelegate.h
//  SpriteAnimationFramework
//
//  Created by Hans Sjunnesson on 2009-03-28.
//  Copyright Hans Sjunnesson 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "HSFrameAnimator.h"

@interface SpriteAnimationFrameworkAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  CALayer *ryu_;
  HSFrameAnimator *animator_;
  bool kicking_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

