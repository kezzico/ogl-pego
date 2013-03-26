//
//  Lines.h
//  Pego
//
//  Created by Lee Irvine on 3/25/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

bool linesCanIntersect(vec3 l1p1, vec3 l1p2, vec3 l2p1, vec3 l2p2);
BOOL segmentsIntersect(vec3 l1p1, vec3 l1p2, vec3 l2p1, vec3 l2p2);
vec3 segmentIntersect(vec3 a, vec3 b, vec3 c, vec3 d);
