//
//  PondTests.m
//  Pego
//
//  Created by Lee Irvine on 3/14/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "PondTests.h"
#import "Pond.h"

@implementation PondTests

- (void) testLoadingStage {
  Pond *pond = [Pond pondWithName:@"testlevel"];
  XCTAssertNotNil(pond);
  XCTAssertEqualObjects(pond.name, @"testlevel");
}

- (void) testStartPosition {
  Pond *pond = [Pond pondWithName:@"testlevel"];
  XCTAssertEqualWithAccuracy(pond.peggyInitialPosition.x, 256.f, 0.1f);
  XCTAssertEqualWithAccuracy(pond.peggyInitialPosition.y, 256.f, 0.1f);
}

- (void) testEggPositions {
  Pond *pond = [Pond pondWithName:@"testlevel"];
  vec3 ice1, ice2;
  
  [pond.eggInitialPositions[0] getValue:&ice1];
  [pond.eggInitialPositions[1] getValue:&ice2];
  
  XCTAssertTrue([pond.eggInitialPositions count] == 2);
  XCTAssertEqualWithAccuracy(ice1.x, 160.f, 0.1f);
  XCTAssertEqualWithAccuracy(ice1.y, 175.5f, 0.1f);
  
  XCTAssertEqualWithAccuracy(ice2.x, 170.734f, 0.1f);
  XCTAssertEqualWithAccuracy(ice2.y, 483.429f, 0.1f);
}

- (void) testIcePositionAndGeometry {
  
}

@end
