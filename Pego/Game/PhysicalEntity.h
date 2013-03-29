//
//  PhysicalEntity.h
//  Pego
//
//  Created by Lee Irvine on 3/23/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZEntity.h"

@interface PhysicalEntity : KZEntity
@property (nonatomic) float mass;
@property (nonatomic) tri bounds;
- (void) sides:(line *) buffer;
@end
