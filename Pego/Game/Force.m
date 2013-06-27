//
//  Force.m
//  PenguinCross
//
//  Created by Lee Irvine on 8/26/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Force.h"

force addForces(force f1, force f2) {
  vec3 v1 = scale(f1.direction, f1.power);
  vec3 v2 = scale(f2.direction, f2.power);
  vec3 result = add(v1, v2);
  vec3 direction = normalize(result);
  float power = distance(_v(0, 0, 0), result);
  
  return _f(direction, power);
}

force scaleForcePower(force f, float s) {
  return _f(f.direction, f.power * s);
  
}
force scaleForceDirection(force f, float s) {
  return _f(scale(f.direction, s), f.power);
}

vec3 vectorWithMass(force f, float mass) {
  return scale(f.direction, f.power / mass);
}