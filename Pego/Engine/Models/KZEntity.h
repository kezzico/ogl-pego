//
//  Entity.h
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KZSprite, KZShader, KZTexture;
@interface KZEntity : NSObject
@property (nonatomic, strong) NSArray *assets;
@property (nonatomic) BOOL isFloating;
@property (nonatomic) vec3 origin;
@property (nonatomic) vec3 lastorigin;
@property (nonatomic) vec3 vector;
@property (nonatomic) vec3 angle;
@property (nonatomic) vec3 dimensions;
+ (KZEntity *) entity:(NSArray *) assets;
- (BOOL) isMoving;
- (BOOL) isTouching:(KZEntity *) e;
- (vec3) vector;
- (float) speed;
@end
