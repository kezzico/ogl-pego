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

- (NSUInteger) numVerts;
- (void) tverts:(GLfloat *) buffer;
- (void) verts: (GLfloat *) buffer;
- (void) normals: (GLfloat *) buffer;
@end
