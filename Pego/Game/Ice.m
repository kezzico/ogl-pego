//
//  Ice.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Ice.h"

@implementation Ice
static vec3 shadowoffset = _v(-12, 8, 0);

+ (Ice *) spawn:(vec3) origin withTriangle:(KZTriangle *) triangle {
  Ice *ice = [[Ice alloc] init];
  
  ice.color = [Ice randomIceColor];
  ice.triangle = triangle;
  ice.shadow = [KZTriangle triangle:triangle.tri];
  ice.assets = @[triangle, ice.shadow];
  
  ice.opacity = 1.f;
  ice.triangle.zIndex = 7;
  ice.shadow.zIndex = 6;
  
  ice.origin = origin;
  ice.shadow.offset = shadowoffset;
  ice.mass = areaOfTriangle(triangle.tri) * 0.0002;
  ice.bounds = _t(triangle.va,triangle.vb,triangle.vc);
  
  ice.canMelt = YES;
  ice.didMelt = NO;
  ice.renderPriority = 1;
  
  return ice;
}

- (void) setOpacity:(float) opacity {
  _triangle.tint = _c(_color.r,_color.g,_color.b, opacity);
  _shadow.tint = _c(.03f,.05f,.18f, opacity);
}

- (float) opacity {
  return _triangle.tint.a;
}

+ (rgba) randomIceColor {
  float m = 255.f;
  rgba colors[] = {
    _c(255.f/m, 255.f/m, 255.f/m,1.f),
    _c(255.f/m, 255.f/m, 255.f/m,1.f),
    _c(255.f/m, 255.f/m, 255.f/m,1.f),
    _c(225.f/m, 243.f/m, 255.f/m,1.f),
    _c(225.f/m, 243.f/m, 255.f/m,1.f),
    _c(168.f/m, 205.f/m, 226.f/m,1.f),
    _c(168.f/m, 205.f/m, 226.f/m,1.f),
    _c(100.f/m, 139.f/m, 160.f/m,1.f),
    _c(149.f/m, 193.f/m, 214.f/m,1.f)
  };
  
  return colors[arc4random() % (sizeof(colors) / sizeof(colors[0]))];
}

@end
