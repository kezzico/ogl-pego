//
//  Vec3.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#define epislon 0.001f
#import "Vec3.h"

BOOL isEqualf(float a, float b) {
  float c = a - b;
  return c < epislon && c > -epislon;
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

TriangleDirection triangleDirection(vec3 pt1, vec3 pt2, vec3 pt3) {
  float test = (((pt2.x - pt1.x)*(pt3.y - pt1.y)) - ((pt3.x - pt1.x)*(pt2.y - pt1.y)));
  if (test > 0) return TriangleDirectionCounterClockwise;
  if(test < 0) return TriangleDirectionClockwise;
  return TriangleDirectionNone;
}

bool linesCanIntersect(vec3 l1p1, vec3 l1p2, vec3 l2p1, vec3 l2p2) {
  int test1_a, test1_b, test2_a, test2_b;
  
  test1_a = triangleDirection(l1p1, l1p2, l2p1);
  test1_b = triangleDirection(l1p1, l1p2, l2p2);
  if (test1_a != test1_b) {
    test2_a = triangleDirection(l2p1, l2p2, l1p1);
    test2_b = triangleDirection(l2p1, l2p2, l1p2);
    if (test2_a != test2_b) return true;
  }
  return false;
}

vec3 segmentIntersect(vec3 a, vec3 b, vec3 c, vec3 d) {
  double d1 = (a.x*b.y - a.y*b.x) * (c.x - d.x) - (a.x - b.x) * (c.x*d.y - c.y*d.x);
  double d2 = (a.x - b.x) * (c.y - d.y) - (a.y - b.y) * (c.x - d.x);
  
  double d3 = (a.x*b.y - a.y*b.x) * (c.y - d.y) - (a.y - b.y) * (c.x*d.y - c.y*d.x);
  double d4 = (a.x - b.x) * (c.y - d.y) - (a.y - b.y) * (c.x - d.x);
  
  return (vec3){d1 / d2, d3 / d4, 0};
}

vec3 centerOfTriangle(vec3 a, vec3 b, vec3 c) {
  vec3 sum = _v((a.x+b.x+c.x),(a.y+b.y+c.y),(a.z+b.z+c.z));
  return scale(sum, 1.f/3.f);
}

NSString *NSStringFromVec3(vec3 a) {
  return [NSString stringWithFormat:@"%0.3f,%0.3f,%0.3f",a.x,a.y,a.z];
}

