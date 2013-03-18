//
//  KZRectangle.h
//  Pego
//
//  Created by Lee Irvine on 3/17/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZRectangle : NSObject <KZAsset>
+ (KZRectangle *) rectangle:(rect) rect;

@property (nonatomic, strong) KZShader *shader;
@property (nonatomic, strong) KZTexture *texture;
@property (nonatomic) vec3 angle;
@property (nonatomic) vec3 offset;
@property (nonatomic) rgba tint;
- (float) width;
- (float) height;
@end
