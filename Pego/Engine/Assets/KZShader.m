//
//  Shader.m
//  Pego
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZShader.h"
#import "KZScreen.h"

@implementation KZShader

+ (KZShader *) shaderWithName:(NSString *) name {
  static NSMutableDictionary *cache = nil;
  if(cache == nil) cache = [[NSMutableDictionary alloc] init];
  
  KZShader *shader = [cache valueForKey: name];
  if(shader == nil) {
    shader = [[KZShader alloc] init];
    [shader loadShaderWithName: name];
    [cache setValue:shader forKey:name];
  }
  
  return shader;
}

+ (KZShader *) defaultShader {
  return [KZShader shaderWithName:@"default"];
}

- (void) dealloc {
  glDeleteProgram(_program);
}

- (void) activate {
  glUseProgram(_program);
}

- (void) loadShaderWithName:(NSString *) name {
  _program = glCreateProgram();
  
  NSString *vshaderpath = [[NSBundle mainBundle] pathForResource:name ofType:@"vsh"];
  NSString *fshaderpath = [[NSBundle mainBundle] pathForResource:name ofType:@"fsh"];
  
  GLuint vshader = [self compileShader:vshaderpath type:GL_VERTEX_SHADER];
  GLuint fshader = [self compileShader:fshaderpath type:GL_FRAGMENT_SHADER];
  
  glAttachShader(_program, vshader);
  glAttachShader(_program, fshader);
  
  glBindAttribLocation(_program, shaderVertexAttribute, "vert");
  glBindAttribLocation(_program, shaderNormalAttribute, "normal");
  glBindAttribLocation(_program, shaderTVertAttribute, "tvert");
  
  glLinkProgram(_program);
  
  _uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation(_program, "modelViewProjectionMatrix");
  _uniforms[UNIFORM_MODELVIEW_MATRIX] = glGetUniformLocation(_program, "modelViewMatrix");
  _uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation(_program, "normalMatrix");
  _uniforms[UNIFORM_TEXTURE] = glGetUniformLocation(_program, "texture");
  _uniforms[UNIFORM_TINT] = glGetUniformLocation(_program, "tint");
  _uniforms[UNIFORM_CAMERA] = glGetUniformLocation(_program, "camera");
  _uniforms[UNIFORM_TICKS] = glGetUniformLocation(_program, "ticks");
  
  glDetachShader(_program, vshader);
  glDetachShader(_program, fshader);
  glDeleteShader(vshader);
  glDeleteShader(fshader);
}

- (GLuint) compileShader:(NSString *) path type: (GLuint) type {
  const char *source = [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] UTF8String];
  GLuint shader = glCreateShader(type);
  glShaderSource(shader, 1, &source, NULL);
  glCompileShader(shader);
#ifdef DEBUG
  GLint logLength;
  glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLength);
  if (logLength > 0) {
    GLchar *log = (GLchar *)malloc(logLength);
    glGetShaderInfoLog(shader, logLength, &logLength, log);
    NSLog(@"Shader error log for %@:\n%s", path, log);
    free(log);
  }
#endif
  
  return shader;
}

- (GLint) modelViewProjectionMatrixUniform {
  return _uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX];
}

- (GLint) modelViewMatrixUniform {
  return _uniforms[UNIFORM_MODELVIEW_MATRIX];
}

- (GLint) normalMatrixUniform {
  return _uniforms[UNIFORM_NORMAL_MATRIX];
}

- (GLint) cameraVectorUniform {
  return _uniforms[UNIFORM_CAMERA];
}

- (GLint) tintUniform {
  return _uniforms[UNIFORM_TINT];
}

- (GLint) ticksUniform {
  return _uniforms[UNIFORM_TICKS];
}
@end
