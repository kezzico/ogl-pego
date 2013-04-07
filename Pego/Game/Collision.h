//
//  Collision.h
//  PenguinCross
//
//  Created by Lee Irvine on 10/6/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KezziEngine.h"
#import "Force.h"

@class Force, PhysicalEntity;
@interface Collision : NSObject
@property (nonatomic, retain) PhysicalEntity *attacker;
@property (nonatomic, retain) PhysicalEntity *victim;
@property (nonatomic) force force;
@property (nonatomic) vec3 point;
@end
