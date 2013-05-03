//
//  Ice.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Ice.h"

@implementation Ice
static vec3 shadowoffset = _v(-6, 8, 0);

+ (Ice *) spawn:(vec3) origin withTriangle:(KZTriangle *) triangle {
  Ice *ice = [[Ice alloc] init];
  ice.triangle = triangle;
  ice.shadow = [KZTriangle triangle:triangle.tri];
  ice.assets = @[ice.shadow, triangle];
  
  ice.triangle.tint = _c(.85, .93, .99, 1.f);
  ice.shadow.tint = _c(.03f,.05f,.18f, 1.f);
  ice.shadow.offset = shadowoffset;
  ice.origin = origin;
  ice.mass = areaOfTriangle(triangle.tri) * 0.0002;
  ice.bounds = _t(triangle.va,triangle.vb,triangle.vc);
  
  return ice;
}

//- (void) update {
//  [super update];
//  vec3 offset = _v(sinf(self.angle.z) * shadowoffset.x, cosf(self.angle.z) * shadowoffset.y, 0);
//  self.shadow.offset = offset;
//}


@end
