//
//  SpriteAnimationFrameworkAppDelegate.m
//  SpriteAnimationFramework
//
//  Created by Hans Sjunnesson (hans.sjunnesson@gmail.com) on 2009-03-28.
//  Copyright Aphelion Consulting AB 2009. All rights reserved.
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

#import "SpriteAnimationFrameworkAppDelegate.h"

@implementation SpriteAnimationFrameworkAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  view_ = [[[UIView alloc] initWithFrame:[window bounds]] autorelease];
  [view_ setBackgroundColor:[UIColor grayColor]];
  [window addSubview:view_];
  
  UIImage *img = [UIImage imageNamed:@"1.png"];
  
  ryu_ = [CALayer layer];
  ryu_.bounds = CGRectMake(0, 0, 290, 178);
  ryu_.position = CGPointMake(160, 240);
  ryu_.contents = (id)img.CGImage;
  
  [view_.layer addSublayer:ryu_];
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button setFrame:CGRectMake(10, 30, 100, 20)];
  [button setTitle:@"Kick/Stand" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
  [view_ addSubview:button];
  
  button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button setFrame:CGRectMake(120, 30, 100, 20)];
  [button setTitle:@"Stop" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(unanimate) forControlEvents:UIControlEventTouchUpInside];
  [view_ addSubview:button];

  button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button setFrame:CGRectMake(10, 60, 100, 20)];
  [button setTitle:@"Add Ryu" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(newSprite) forControlEvents:UIControlEventTouchUpInside];
  [view_ addSubview:button];
  
  [window makeKeyAndVisible];

  
  // Create the sprite animator
  animator_ = [[HSFrameAnimator alloc] init];
  
  // Load a bunch of frames
  NSMutableArray *frameset = [[[NSMutableArray alloc] init] autorelease];
  
  for (int i = 0; i < 10; i++) {
    NSString *filename = [NSString stringWithFormat:@"stand_%d.png", i+1];
    UIImage *img = [UIImage imageNamed:filename];
    [frameset addObject:img];
  }
  
  [animator_ addFrameset:frameset forKey:@"STAND"];
  
  frameset = [[[NSMutableArray alloc] init] autorelease];
  
  for (int i = 0; i < 13; i++) {
    NSString *filename = [NSString stringWithFormat:@"kick_%d.png", i+1];
    UIImage *img = [UIImage imageNamed:filename];
    [frameset addObject:img];
  }

  [animator_ addFrameset:frameset forKey:@"KICK"];
  
  [animator_ registerSprite:ryu_ forFrameset:@"STAND"];
  [animator_ setFramerate:1.0/15.0];
  
  [animator_ startTimer];
  
  kicking_ = false;
}

- (void)dealloc {
    [window release];
    [super dealloc];
}

@end

@implementation SpriteAnimationFrameworkAppDelegate (private)

- (void)buttonPressed {
  if (kicking_) {
    [animator_ registerSprite:ryu_ forFrameset:@"STAND"];
    kicking_ = false;
  } else {
    [animator_ registerSprite:ryu_ forFrameset:@"KICK"];
    kicking_ = true;
  }
}

- (void)unanimate {
  [animator_ deregisterSprite:ryu_];
}

- (void)newSprite {
  CALayer *sprite = [CALayer layer];
  sprite.bounds = CGRectMake(0, 0, 290, 178);
  
  float x = ((float)random()/RAND_MAX) * 320.0;
  float y = ((float)random()/RAND_MAX) * 480.0;
  sprite.position = CGPointMake(x, y);
  [view_.layer addSublayer:sprite];
  
  [animator_ registerSprite:sprite forFrameset:@"STAND"];
}

@end

