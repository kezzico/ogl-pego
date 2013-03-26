//
//  Background.m
//  Pego
//
//  Created by Lee Irvine on 3/22/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Water.h"

@implementation Water

+ (Water *) spawn {
  Water *water = [[Water alloc] init];

  vec3 tl = _v(0, 0, 0);
  vec3 br = _v(1024, 768, 0);
  rect r =_r(tl, br);
  
  KZRectangle *back = [KZRectangle rectangle: r];
  KZRectangle *front = [KZRectangle rectangle: r];
  
  back.tint = _c(.31f, .65f, .98f, 1.f);
  front.tint = _c(.31f, .65f, .98f, .4f);
  back.texture = [KZTexture textureWithName:@"white"];
  front.texture = [KZTexture textureWithName:@"white"];
  
  water.assets = @[back,front];
  
  return water;
}

@end
