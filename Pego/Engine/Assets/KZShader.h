//
//  Shader.h
//  Pego
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
  shaderVertexAttribute,
  shaderNormalAttribute,
  shaderTVertAttribute
};

enum {
  UNIFORM_MODELVIEWPROJECTION_MATRIX,
  UNIFORM_MODELVIEW_MATRIX,
  UNIFORM_NORMAL_MATRIX,
  UNIFORM_TINT,
  UNIFORM_TEXTURE,
  UNIFORM_CAMERA,
  UNIFORM_TICKS,
  NUM_UNIFORMS
};


@interface KZShader : NSObject {
  GLuint _program;
  GLint _uniforms[NUM_UNIFORMS];
}
+ (KZShader *) shaderWithName:(NSString *) name;
+ (KZShader *) defaultShader;

- (GLint) modelViewProjectionMatrixUniform;
- (GLint) modelViewMatrixUniform;
- (GLint) normalMatrixUniform;
- (GLint) cameraVectorUniform;
- (GLint) tintUniform;
- (GLint) ticksUniform;

- (void) activate;
@end
