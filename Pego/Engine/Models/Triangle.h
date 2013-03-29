//
//  Triangle.h
//  Pego
//
//  Created by Lee Irvine on 3/25/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#define _t(a,b,c) ((tri){a,b,c})

typedef struct {
  vec3 a,b,c;
} tri;

typedef enum {
  TriangleDirectionNone,
  TriangleDirectionCounterClockwise,
  TriangleDirectionClockwise
} TriangleDirection;

TriangleDirection triangleDirection(tri t);
vec3 centerOfTriangle(vec3 a, vec3 b, vec3 c);
BOOL isPointInTriangle(vec3 p, tri t);