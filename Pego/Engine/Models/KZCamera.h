//
//  Camera.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/19/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZCamera : NSObject
@property (nonatomic, assign) GLKMatrix4 viewMatrix;
+ (KZCamera *) eye:(vec3) eye;
- (void) eye:(vec3)eye;
+ (KZCamera *) camera;
@end
