//
//  PhysicalEntity.h
//  Pego
//
//  Created by Lee Irvine on 3/23/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZEntity.h"
#import "Force.h"

@interface PhysicalEntity : KZEntity
@property (nonatomic) float mass;
@property (nonatomic) float lastAngle;
@property (nonatomic) float angleVector;
@property (nonatomic) vec3 lastorigin;
@property (nonatomic) force force;
@property (nonatomic) tri bounds;
- (void) sides:(line *) buffer;
- (BOOL) isMoving;
@end
