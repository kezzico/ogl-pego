//
//  Lines.m
//  Pego
//
//  Created by Lee Irvine on 3/25/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Lines.h"

bool linesCanIntersect(vec3 l1p1, vec3 l1p2, vec3 l2p1, vec3 l2p2) {
  int test1_a, test1_b, test2_a, test2_b;
  
  test1_a = triangleDirection(_t(l1p1, l1p2, l2p1));
  test1_b = triangleDirection(_t(l1p1, l1p2, l2p2));
  if (test1_a != test1_b) {
    test2_a = triangleDirection(_t(l2p1, l2p2, l1p1));
    test2_b = triangleDirection(_t(l2p1, l2p2, l1p2));
    if (test2_a != test2_b) return YES;
  }
  return NO;
}
BOOL segmentsIntersect(vec3 l1p1, vec3 l1p2, vec3 l2p1, vec3 l2p2) {
  vec3 u0 = l1p1, u1 = l2p1;
  vec3 v0 = sub(l1p2, l1p1), v1 = sub(l2p2, l2p1);
  float d = v1.x * v0.y - v0.x * v1.y;
  
  if(isZerof(d)) return NO;
  
  float s = (1.f / d) * ((u0.x - u1.x) * v0.y - (u0.y - u1.y) * v0.x);
  float t = (1.f / d) * -(-(u0.x - u1.x) * v1.y + (u0.y - u1.y) * v1.x);
  
  return s <= 1.f && s >= 0.f && t <= 1.f && t >= 0.f;
}

vec3 segmentIntersect(vec3 a, vec3 b, vec3 c, vec3 d) {
  double d1 = (a.x*b.y - a.y*b.x) * (c.x - d.x) - (a.x - b.x) * (c.x*d.y - c.y*d.x);
  double d2 = (a.x - b.x) * (c.y - d.y) - (a.y - b.y) * (c.x - d.x);
  
  double d3 = (a.x*b.y - a.y*b.x) * (c.y - d.y) - (a.y - b.y) * (c.x*d.y - c.y*d.x);
  double d4 = (a.x - b.x) * (c.y - d.y) - (a.y - b.y) * (c.x - d.x);
  
  return (vec3){d1 / d2, d3 / d4, 0};
}
