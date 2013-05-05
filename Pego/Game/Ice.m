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
  _triangle.tint = _c(1.f,1.f,1.f, opacity);
  _shadow.tint = _c(.03f,.05f,.18f, opacity);
}

- (float) opacity {
  return _triangle.tint.a;
}

@end
