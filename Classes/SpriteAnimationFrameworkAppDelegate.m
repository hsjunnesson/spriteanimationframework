//
//  SpriteAnimationFrameworkAppDelegate.m
//  SpriteAnimationFramework
//
//  Created by Hans Sjunnesson on 2009-03-28.
//  Copyright Aphelion Consulting AB 2009. All rights reserved.
//

#import "SpriteAnimationFrameworkAppDelegate.h"

@implementation SpriteAnimationFrameworkAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  UIView *view = [[[UIView alloc] initWithFrame:[window bounds]] autorelease];
  [view setBackgroundColor:[UIColor grayColor]];
  [window addSubview:view];
  
  UIImage *img = [UIImage imageNamed:@"1.png"];
  
  ryu_ = [CALayer layer];
  ryu_.bounds = CGRectMake(0, 0, 290, 178);
  ryu_.position = CGPointMake(160, 240);
  ryu_.contents = (id)img.CGImage;
  
  [view.layer addSublayer:ryu_];
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button setFrame:CGRectMake(20, 20, 20, 20)];
  [button setTitle:@"foo" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
  [view addSubview:button];
  
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

@end

