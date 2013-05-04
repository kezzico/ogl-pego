//
//  Egg.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Egg.h"

@implementation Egg
+ (Egg *) spawn: (vec3) origin {
  Egg *egg = [[Egg alloc] init];
  egg.sprite = [KZSprite spriteWithName:@"egg"];
  egg.sprite.zIndex = 10;
  egg.sprite.animation.animationLoop = @"egg";
  
  egg.assets = @[egg.sprite];
  egg.origin = origin;
  
  GLfloat s = 20.f;
  egg.bounds = _t(_v(-s, s, 0), _v(s, s, 0), _v(0, -s, 0));

  return egg;
}
@end
