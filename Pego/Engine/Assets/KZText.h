//
//  Text.h
//  Cheapo
//
//  Created by Lee Irvine on 2/28/13.
//  Copyright (c) 2013 fareportal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZAsset.h"

@interface KZText : NSObject <KZAsset>
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) KZTexture *texture;
@property (nonatomic, strong) KZShader *shader;
@property (nonatomic) GLfloat scale;
@property (nonatomic) vec3 angle;
@property (nonatomic) vec3 offset;
@property (nonatomic) rgba tint;

- (NSUInteger) numVerts;
+ (KZText *) textWithString:(NSString *) string scale:(GLfloat) scale;

@end
