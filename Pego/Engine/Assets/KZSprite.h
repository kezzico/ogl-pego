//
//  Sprite.h
//  Cheapo
//
//  Created by Lee Irvine on 11/7/11.
//  Copyright (c) 2013 Fareportal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZAsset.h"

@interface KZSprite : NSObject <KZAsset>

@property (nonatomic, strong) KZAnimation *animation;
@property (nonatomic, strong) KZTexture *texture;
@property (nonatomic, strong) KZShader *shader;
@property (nonatomic) vec3 angle;
@property (nonatomic) vec3 offset;
@property (nonatomic) rgba tint;
@property (nonatomic) GLfloat scale;

+ (KZSprite *) spriteWithName:(NSString *) name;
+ (KZSprite *) spriteWithTexture:(KZTexture *) texture;
@end
