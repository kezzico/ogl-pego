//
//  Force.h
//  PenguinCross
//
//  Created by Lee Irvine on 8/26/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Entity;
@interface Force : NSObject
@property (nonatomic, retain) Entity *subject;
@property (nonatomic) vec3 direction;
@property (nonatomic) float massAcceleration;

@end
