//
//  Vec3.h
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  TriangleDirectionNone,
  TriangleDirectionCounterClockwise,
  TriangleDirectionClockwise
} TriangleDirection;

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
BOOL isEqualv(vec3 a, vec3 b);
BOOL isZerov(vec3 a);
vec3 normalize(vec3 p);
float angleFromOrigin(vec3 origin, vec3 a);
bool linesCanIntersect(vec3 l1p1, vec3 l1p2, vec3 l2p1, vec3 l2p2);
vec3 segmentIntersect(vec3 a, vec3 b, vec3 c, vec3 d);
vec3 _2d(vec3 a);

TriangleDirection triangleDirection(vec3 pt1, vec3 pt2, vec3 pt3);
vec3 centerOfTriangle(vec3 a, vec3 b, vec3 c);

NSString* NSStringFromVec3(vec3 a);
