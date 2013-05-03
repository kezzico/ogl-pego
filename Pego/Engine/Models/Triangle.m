//
//  Triangle.m
//  Pego
//
//  Created by Lee Irvine on 3/25/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Triangle.h"

TriangleDirection triangleDirection(tri t) {
  float test = (((t.b.x - t.a.x)*(t.c.y - t.a.y)) - ((t.c.x - t.a.x)*(t.b.y - t.a.y)));
  if (test > 0) return TriangleDirectionCounterClockwise;
  if(test < 0) return TriangleDirectionClockwise;
  return TriangleDirectionNone;
}

vec3 centerOfTriangle(tri t) {
  vec3 sum = _v((t.a.x+t.b.x+t.c.x),(t.a.y+t.b.y+t.c.y),(t.a.z+t.b.z+t.c.z));
  return scale(sum, 1.f/3.f);
}

BOOL isPointInTriangle(vec3 p, tri t) {
  vec3 v0 = sub(t.c, t.a); v0.z = 0.0f;
  vec3 v1 = sub(t.b, t.a); v1.z = 0.0f;
  vec3 v2 = sub(p, t.a); v2.z = 0.0f;
  
  float dot00 = dot(v0,v0);
  float dot01 = dot(v0,v1);
  float dot02 = dot(v0,v2);
  float dot11 = dot(v1,v1);
  float dot12 = dot(v1,v2);
  
  float invDenom = 1.0f / (dot00 * dot11 - dot01 * dot01);
  float u = (dot11 * dot02 - dot01 * dot12) * invDenom;
  float v = (dot00 * dot12 - dot01 * dot02) * invDenom;
  
  return u >= 0.0f && v >= 0.0f && u + v <= 1.0f;
}

float areaOfTriangle(tri t) {
  return fabsf((t.a.x*(t.b.y - t.c.y) + t.b.x*(t.c.y - t.a.y) + t.c.x*(t.a.y - t.b.y)) *.5f);
}
