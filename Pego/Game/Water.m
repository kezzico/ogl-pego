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
  
  KZRectangle *front = [KZRectangle rectangle: r];
  
  front.tint = _c(.05f, .1f, .36f, 1.f);
  front.texture = [KZTexture textureWithName:@"white"];
  
  water.assets = @[front];
  
  return water;
}

@end
