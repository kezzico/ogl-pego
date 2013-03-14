//
//  Camera.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/19/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZCamera : NSObject
@property (nonatomic, readonly) vec3 up;
@property (nonatomic, readonly) vec3 origin;
@property (nonatomic, readonly) vec3 eye;
@property (nonatomic, readonly) vec3 tilt;

+ (KZCamera *) eye:(vec3) eye origin:(vec3) origin;
+ (KZCamera *) eye:(vec3) eye;
- (void) eye:(vec3)eye origin:(vec3) origin;
- (void) eye:(vec3)eye;
+ (KZCamera *) camera;
@end
