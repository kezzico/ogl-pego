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
  STAssertNotNil(pond, nil);
  STAssertEqualObjects(pond.name, @"testlevel", nil);
}

- (void) testStartPosition {
  Pond *pond = [Pond pondWithName:@"testlevel"];
  STAssertEqualsWithAccuracy(pond.peggyInitialPosition.x, 256.f, 0.1f, nil);
  STAssertEqualsWithAccuracy(pond.peggyInitialPosition.y, 256.f, 0.1f, nil);
}

- (void) testEggPositions {
  Pond *pond = [Pond pondWithName:@"testlevel"];
  vec3 ice1, ice2;
  
  [pond.eggInitialPositions[0] getValue:&ice1];
  [pond.eggInitialPositions[1] getValue:&ice2];
  
  STAssertTrue([pond.eggInitialPositions count] == 2, nil);
  STAssertEqualsWithAccuracy(ice1.x, 160.f, 0.1f, nil);
  STAssertEqualsWithAccuracy(ice1.y, 175.5f, 0.1f, nil);
  
  STAssertEqualsWithAccuracy(ice2.x, 170.734f, 0.1f, nil);
  STAssertEqualsWithAccuracy(ice2.y, 483.429f, 0.1f, nil);
}

- (void) testIcePositionAndGeometry {
  
}

@end
