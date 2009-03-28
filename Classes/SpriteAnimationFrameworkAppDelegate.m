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

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
