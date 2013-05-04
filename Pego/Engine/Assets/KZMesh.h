//
//  Mesh.h
//  Kezzi-Engine
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZAsset.h"
@interface KZMesh : NSObject <KZAsset>
@property (nonatomic, strong) KZTexture *texture;
@property (nonatomic, strong) KZAnimation *animation;
@property (nonatomic, strong) KZShader *shader;
@property (nonatomic) vec3 angle;
@property (nonatomic) vec3 offset;
@property (nonatomic) rgba tint;
@property (nonatomic) BOOL hidden;
@property (nonatomic) NSInteger zIndex;

+ (KZMesh *) meshWithName:(NSString *) name;

@end
