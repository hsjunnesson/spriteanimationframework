//
//  HSSprite.h
//  SpriteAnimationFramework
//
//  Created by Hans Sjunnesson (hans.sjunnesson@gmail.com) on 2009-03-30.
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
#import "HSFrameAnimator.h"

@interface HSSprite : NSObject {
 @private
  CALayer *sprite_;
  int frame_;
  NSString *frameset_;
  HSAnimationMode animationMode_;
}

@property (nonatomic, retain) CALayer *sprite;
@property (nonatomic, assign) int frame;
@property (nonatomic, assign) NSString *frameset;
@property (nonatomic, assign) HSAnimationMode animationMode;

@end
