//
//  Asset.h
//  KezziEngine
//
//  Created by Lee Irvine on 3/3/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

@protocol KZAsset <NSObject>
@required
- (KZAnimation *) animation;
- (KZTexture *) texture;
- (KZShader *) shader;
- (vec3) angle;
- (vec3) offset;
- (rgba) tint;
- (BOOL) hidden;
- (NSInteger) zIndex;
- (GLKMatrix4) modelMatrix;

- (GLuint) numVerts;
- (void) tverts:(GLfloat *) buffer;
- (void) verts: (GLfloat *) buffer;
- (void) normals: (GLfloat *) buffer;
@end

@interface KZAsset : NSObject <KZAsset>
@property (nonatomic) vec3 angle;
@property (nonatomic) vec3 offset;
@property (nonatomic) rgba tint;
@property (nonatomic) BOOL hidden;
@property (nonatomic) NSInteger zIndex;
@property (nonatomic, strong) KZShader *shader;
@property (nonatomic, strong) KZTexture *texture;

@end
