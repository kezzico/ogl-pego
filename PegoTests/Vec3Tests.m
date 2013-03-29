//
//  Vec3Tests.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Vec3Tests.h"

@implementation Vec3Tests
- (void) testTriangleDirection {
  vec3 a = _v(0,0,0);
  vec3 b = _v(100, 0, 0);
  vec3 c = _v(0,100,0);
  
  TriangleDirection counterclickwise = triangleDirection(_t(a, b, c));
  STAssertTrue(counterclickwise == TriangleDirectionCounterClockwise, nil);
  
  TriangleDirection clockwise = triangleDirection(_t(a, c, b));
  STAssertTrue(clockwise == TriangleDirectionClockwise, nil);
}

- (void) testSegmentIntersection {
  vec3 line1[2] = {
    _v(0, 0, 0),
    _v(0, 2, 0)
  };

  vec3 line2[2] = {
    _v( 1.f, 1.f, 0),
    _v(-1.f, 2.f, 0)
  };

  vec3 line3[2] = {
    _v(0, -1, 0),
    _v(-2, -2, 0)
  };

  BOOL result1 = doSegmentsIntersect(_l(line1[0],line1[1]),_l(line2[0],line2[1]));
  BOOL result2 = doSegmentsIntersect(_l(line1[0],line1[1]),_l(line3[0],line3[1]));
  
  STAssertTrue(result1, nil);
  STAssertFalse(result2, nil);
}

- (void) testPointInsideTriangle {
  vec3 p1 = _v(0, 0, 0);
  vec3 p2 = _v(100, 0, 0);
  
  tri t = _t(_v(-1, -1, 0), _v(1, -1, 0), _v(0, 1, 0));
  
  STAssertTrue(isPointInTriangle(p1, t), nil);
  STAssertFalse(isPointInTriangle(p2, t), nil);
}

- (void) testDistanceToLine {
  vec3 p = _v(0, 0, 0);
  line l1 = _l(_v(0,1,0), _v(0, 0, 0));
  float result1 = distanceToLine(l1, p);
  
  STAssertEqualsWithAccuracy(result1, 0.f, 0.01f, nil);
  
  line l2 = _l(_v(10,10,0), _v(-10, 20, 0));
  float result2 = distanceToLine(l2, p);
  
  STAssertEqualsWithAccuracy(result2, 13.41f, 0.01f, nil);
}

@end
