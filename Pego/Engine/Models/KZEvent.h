//
//  Event.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/19/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZEvent : NSObject
@property (nonatomic, copy) void (^action)();
@property (nonatomic) NSUInteger nextTick;
@property (nonatomic) BOOL isRepeating;
@property (nonatomic) float interval;

+ (KZEvent *) after:(float) seconds run:(void(^)()) action;
+ (KZEvent *) every:(float) seconds loop:(void(^)()) action;
- (void) calculateNextTick;
- (void) cancel;
@end
