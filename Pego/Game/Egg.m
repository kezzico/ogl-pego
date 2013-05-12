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
  egg.sprite.animation.animationLoop = @"egg";
  egg.sprite.zIndex = 11;

  KZRectangle *shadow = [KZRectangle rectangle:_r(_v(-16, -16, 0), _v(16, 16, 0))];
  shadow.texture = [KZTexture textureWithName:@"eggshadow"];
  shadow.zIndex = 9;
  shadow.offset = _v(-8, 8, 0);
  
  egg.assets = @[shadow, egg.sprite];
  egg.origin = origin;
  
  GLfloat s = 20.f;
  egg.bounds = _t(_v(-s, s, 0), _v(s, s, 0), _v(0, -s, 0));
  egg.renderPriority = 2;

  return egg;
}

@end
