//
//  PhysicsTests.m
//  Pego
//
//  Created by Lee Irvine on 3/24/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "PhysicsTests.h"
#import "PhysicalEntity.h"

@implementation PhysicsTests

- (void) testPhysicalEntityTouchingEdges {
  PhysicalEntity *a = [[PhysicalEntity alloc] init];
  PhysicalEntity *b = [[PhysicalEntity alloc] init];
  
  a.origin = _v(0, 0, 0);
  a.bounds = _t(_v(0, 0, 0), _v(0, 1, 0), _v(1, 0, 0));
  
  b.origin = _v(.5f, .5f, 0);
  b.bounds = _t(_v(0, 0, 0), _v(0, 1, 0), _v(1, 0, 0));
  
  XCTAssertTrue([a isTouching:b]);
  
  b.origin = add(b.origin, _v(100, 0, 0));
  XCTAssertFalse([a isTouching:b]);
}

- (void) testPhysicalEntityTouchInside {
  PhysicalEntity *a = [[PhysicalEntity alloc] init];
  PhysicalEntity *b = [[PhysicalEntity alloc] init];
  
  a.origin = _v(-100, 0, 0);
  a.bounds = _t(_v(200, 200, 0), _v(200, -200, 0), _v(-200, -200, 0));
  
  b.origin = _v(0, 0, 0);
  b.bounds = _t(_v(1, 1, 0), _v(1, -1, 0), _v(-1, -1, 0));
  
  XCTAssertTrue([a isTouching:b]);
}

@end
