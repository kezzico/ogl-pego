//
//  Vec3.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#define epislon 0.001f
#import "Vec3.h"

BOOL isEqualf(float a, float b) {
  float c = a - b;
  return c < epislon && c > -epislon;
}
BOOL isZerof(float a) {
  return isEqualf(a, 0.f);
}
BOOL isEqualv(vec3 a, vec3 b) {
  return isEqualf(a.x, b.x) && isEqualf(a.y, b.y) && isEqualf(a.z, b.z);
}
BOOL isZerov(vec3 a) {
  return isEqualf(a.x, 0.f) && isEqualf(a.y, 0.f) && isEqualf(a.z, 0.f);  
}
vec3 _2d(vec3 a) {
  return (vec3){a.x, a.y, 0};
}
vec3 add(vec3 a, vec3 b) {
  return (vec3){a.x+b.x,a.y+b.y,a.z+b.z};
}
vec3 sub(vec3 a, vec3 b) {
  return (vec3){a.x-b.x,a.y-b.y,a.z-b.z};
}
vec3 scale(vec3 a, float s) {
  return (vec3){a.x*s,a.y*s,a.z*s};
}
float dot(vec3 a, vec3 b) {
  return a.x * b.x + a.y * b.y + a.z * b.z;
}
vec3 cross(vec3 a, vec3 b) {
  return (vec3){
    ((a.y * b.z) - (a.z * b.y)),
    ((a.z * b.x) - (a.x * b.z)),
    ((a.x * b.y) - (a.y * b.x))
  };
}
vec3 midpoint(vec3 a, vec3 b) {
  return _v((a.x+b.x)*.5f,(a.y+b.y)*.5f,(a.z+b.z)*.5f);
}
float distance(vec3 a, vec3 b) {
  vec3 p = sub(b, a);
  return sqrt(dot(p, p));
}

vec3 normalize(vec3 p) {
  float magnitude = sqrtf(dot(p,p));
  if(magnitude == 0.0f) return (vec3){0.0f, 0.0f, 0.0f};
  return scale(p, 1.0f / magnitude);
}

float trimf(float n) {
  const float tolerance = 1000.0f;
  return ((int)(n * tolerance)) / tolerance;
}

float angleFromOrigin(vec3 origin, vec3 a) {
  return atan2f(a.x - origin.x, origin.y - a.y);
}

vec3 rotate(vec3 p, vec3 origin, vec3 angle) {
  vec3 po = sub(p, origin);
  
  if(isZerof(angle.x)) {
    float s = sinf(angle.x), c = cosf(angle.x);
    po = _v(po.x, po.z*s + po.y*c, po.z*c - po.y*s);
  }
  if(isZerof(angle.y)) {
    float s = sinf(angle.y), c = cosf(angle.y);
    po = _v(po.x*c - po.z*s, po.y, po.x*s + po.z*c);
  }
  if(isZerof(angle.z)) {
    float s = sinf(angle.z), c = cosf(angle.z);
    po = _v(po.x*c - po.y*s, po.x*s + po.y*c, po.z);
  }
  
  return add(po, origin);
}

NSString *NSStringFromVec3(vec3 a) {
  return [NSString stringWithFormat:@"%0.3f,%0.3f,%0.3f",a.x,a.y,a.z];
}

