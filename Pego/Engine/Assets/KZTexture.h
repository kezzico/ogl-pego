//
//  Texture.h
//  Penguin Cross
//
//  Created by Lee Irvine on 12/25/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZTexture : NSObject
@property (atomic, strong) GLKTextureInfo *info;
@property (nonatomic) GLfloat scale;
+ (KZTexture *) textureWithName:(NSString *) name;
- (GLuint) textureId;
@end
