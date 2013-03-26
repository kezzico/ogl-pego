//
//  Vec3.h
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
  float x,y,z;
} vec3;
typedef struct {
  float x,y;
} vec2;
typedef struct {
  float r,g,b,a;
} rgba;

vec3 add(vec3 a, vec3 b);
vec3 sub(vec3 a, vec3 b);
vec3 scale(vec3 a, float s);
float dot(vec3 a, vec3 b);
vec3 cross(vec3 a, vec3 b);
vec3 midpoint(vec3 a, vec3 b);
float distance(vec3 a, vec3 b);
float trimf(float n);
BOOL isEqualf(float a, float b);
BOOL isZerof(float a);
BOOL isEqualv(vec3 a, vec3 b);
BOOL isZerov(vec3 a);
vec3 normalize(vec3 p);
float angleFromOrigin(vec3 origin, vec3 a);
vec3 rotate(vec3 p, vec3 origin, vec3 angle);
vec3 _2d(vec3 a);

NSString* NSStringFromVec3(vec3 a);
