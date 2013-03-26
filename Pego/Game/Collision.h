//
//  Collision.h
//  PenguinCross
//
//  Created by Lee Irvine on 10/6/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KezziEngine.h"

@class Entity;
@class Force;
@interface Collision : NSObject
@property (nonatomic, retain) Entity *attacker;
@property (nonatomic, retain) Entity *victim;
@property (nonatomic) float massAcceleration;
@property (nonatomic) vec3 direction;
@property (nonatomic) vec3 point;
@end
