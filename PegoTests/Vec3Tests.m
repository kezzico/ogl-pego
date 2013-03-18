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
  
  TriangleDirection counterclickwise = triangleDirection(a, b, c);
  STAssertTrue(counterclickwise == TriangleDirectionCounterClockwise, nil);
  
  TriangleDirection clockwise = triangleDirection(a, c, b);
  STAssertTrue(clockwise == TriangleDirectionClockwise, nil);
}

@end
