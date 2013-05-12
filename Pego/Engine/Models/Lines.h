//
//  Lines.h
//  Pego
//
//  Created by Lee Irvine on 3/25/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#define _l(p1, p2) ((line){p1, p2})

typedef struct {
  vec3 p1, p2;
} line;

BOOL isSphereAboveSegment(vec3 p, float radius, line l);
BOOL linesCanIntersect(line l1, line l2);
BOOL doSegmentsIntersect(line l1, line l2);
vec3 findSegmentIntersect(line l1, line l2);
float distanceToLine(line l, vec3 p);