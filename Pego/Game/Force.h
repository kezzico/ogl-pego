//
//  Force.h
//  PenguinCross
//
//  Created by Lee Irvine on 8/26/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#define _f(direction, power) ((force){direction, power})
#define _fzero ((force){_vzero, 0.f})

typedef struct {
  vec3 direction;
  float power;
} force;

force addForces(force f1, force f2);
force scaleForcePower(force f, float s);
force scaleForceDirection(force f, float s);
vec3 vectorWithMass(force f, float mass);