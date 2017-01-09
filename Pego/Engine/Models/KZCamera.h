//
//  Camera.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/19/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZCamera : NSObject
+ (KZCamera *) eye:(vec3) eye origin:(vec3) origin;
+ (KZCamera *) eye:(vec3) eye;
- (void) eye:(vec3)eye origin:(vec3) origin;
- (void) eye:(vec3)eye;
+ (KZCamera *) camera;
- (GLKMatrix4) viewMatrix;
@end
