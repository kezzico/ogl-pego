//
//  Ice.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Ice.h"

@implementation Ice

+ (Ice *) spawn:(vec3) origin withTriangle:(KZTriangle *) triangle {
  Ice *ice = [[Ice alloc] init];
  ice.triangle = triangle;
  ice.assets = @[triangle];
  ice.triangle.tint = _c(.85, .93, .99, 1.f);
  ice.origin = origin;
  ice.mass = areaOfTriangle(triangle.tri) * 0.0002;
  ice.bounds = _t(triangle.va,triangle.vb,triangle.vc);
  
  return ice;
}

@end
