//
//  SpriteAnimationFrameworkAppDelegate.h
//  SpriteAnimationFramework
//
//  Created by Hans Sjunnesson (hans.sjunnesson@gmail.com) on 2009-03-28.
//  Copyright Hans Sjunnesson 2009. All rights reserved.
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

