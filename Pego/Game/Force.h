//
//  Force.h
//  PenguinCross
//
//  Created by Lee Irvine on 8/26/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PhysicalEntity;
@interface Force : NSObject
@property (nonatomic, retain) PhysicalEntity *subject;
@property (nonatomic) vec3 direction;
@property (nonatomic) float massAcceleration;

@end
