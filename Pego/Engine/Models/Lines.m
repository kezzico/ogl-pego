//
//  Lines.m
//  Pego
//
//  Created by Lee Irvine on 3/25/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Lines.h"

BOOL linesCanIntersect(line l1, line l2) {
  int test1_a, test1_b, test2_a, test2_b;
  
  test1_a = triangleDirection(_t(l1.p1, l1.p2, l2.p1));
  test1_b = triangleDirection(_t(l1.p1, l1.p2, l2.p2));
  if (test1_a != test1_b) {
    test2_a = triangleDirection(_t(l2.p1, l2.p2, l1.p1));
    test2_b = triangleDirection(_t(l2.p1, l2.p2, l1.p2));
    if (test2_a != test2_b) return YES;
  }
  return NO;
}
BOOL doSegmentsIntersect(line l1, line l2) {
  vec3 u0 = l1.p1, u1 = l2.p1;
  vec3 v0 = sub(l1.p2, l1.p1), v1 = sub(l2.p2, l2.p1);
  float d = v1.x * v0.y - v0.x * v1.y;
  
  if(isZerof(d)) return NO;
  
  float s = (1.f / d) * ((u0.x - u1.x) * v0.y - (u0.y - u1.y) * v0.x);
  float t = (1.f / d) * -(-(u0.x - u1.x) * v1.y + (u0.y - u1.y) * v1.x);
  
  return s <= 1.f && s >= 0.f && t <= 1.f && t >= 0.f;
}

BOOL isSphereAboveSegment(vec3 p, float radius, line l) {
  float length = distance(l.p1,l.p2);
  float pad = radius / length;
  float t = ((p.x - l.p1.x) * (l.p2.x - l.p1.x) + (p.y - l.p1.y) * (l.p2.y - l.p1.y)) / (length*length);
  return t <= 1 + pad - 0.01 && t >= 0 - pad + 0.01;
  
}

vec3 findSegmentIntersect(line l1, line l2) {
  double d1 = (l1.p1.x*l1.p2.y - l1.p1.y*l1.p2.x) * (l2.p1.x - l2.p2.x) - (l1.p1.x - l1.p2.x) * (l2.p1.x*l2.p2.y - l2.p1.y*l2.p2.x);
  double d2 = (l1.p1.x - l1.p2.x) * (l2.p1.y - l2.p2.y) - (l1.p1.y - l1.p2.y) * (l2.p1.x - l2.p2.x);
  
  double d3 = (l1.p1.x*l1.p2.y - l1.p1.y*l1.p2.x) * (l2.p1.y - l2.p2.y) - (l1.p1.y - l1.p2.y) * (l2.p1.x*l2.p2.y - l2.p1.y*l2.p2.x);
  double d4 = (l1.p1.x - l1.p2.x) * (l2.p1.y - l2.p2.y) - (l1.p1.y - l1.p2.y) * (l2.p1.x - l2.p2.x);
  
  return (vec3){d1 / d2, d3 / d4, 0};
}

float distanceToLine(line l, vec3 p) {
  vec3 n = normalize(sub(l.p1, l.p2));
  n = _v(n.y, -n.x, 0);
  return fabsf(dot(n, p) - dot(n, l.p1));
}

