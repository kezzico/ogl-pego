//
//  Renderer.m
//  Penguin Cross
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZRenderer.h"
#import "KZView.h"
#import "KZScreen.h"
#import "KZAsset.h"

@implementation KZRenderer

- (void) dealloc {
  if(_vertBuffer) free(_vertBuffer);
  if(_normalBuffer) free(_normalBuffer);
  if(_tvertBuffer) free(_tvertBuffer);
}

- (void) setup {  
  glEnable(GL_BLEND);
  glEnable(GL_CULL_FACE);
  glCullFace(GL_BACK);
  glActiveTexture (GL_TEXTURE0);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glClearColor(0.5f, 0.5f, 0.5f, 1.0f);

  KZScreen *screen = [KZScreen shared];
  if(screen == nil) {
    NSLog(@"Warning: setupScreen not called on KZScreen");
  }
}

- (void) clear {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

- (void) renderEntity:(KZEntity *) e {
  NSUInteger ticks = [[KZStage stage] ticks];
  KZScreen *screen = [KZScreen shared];
  GLKMatrix4 mmatrix = screen.modelViewMatrix;

  if([screen screenMode] == KZScreenModePerspective) glEnable(GL_DEPTH_TEST);
  else glDisable(GL_DEPTH_TEST);
  glEnableVertexAttribArray(shaderVertexAttribute);
  glEnableVertexAttribArray(shaderTVertAttribute);
  glEnableVertexAttribArray(shaderNormalAttribute);

  for(id<KZAsset> asset in e.assets) {
    [screen translate: add(e.origin, asset.offset)];
    [screen rotate:_v(1,0,0) angle: e.angle.x + asset.angle.x];
    [screen rotate:_v(0,1,0) angle: e.angle.y + asset.angle.y];
    [screen rotate:_v(0,0,1) angle: e.angle.z + asset.angle.z];
    
    [asset.shader activate];
    glUniformMatrix4fv(asset.shader.modelViewProjectionMatrixUniform, 1, 0, screen.modelViewProjectionMatrix.m);
    glUniformMatrix4fv(asset.shader.modelViewMatrixUniform, 1, 0, screen.modelViewMatrix.m);
    glUniform4f(asset.shader.tintUniform, asset.tint.r, asset.tint.g, asset.tint.b, asset.tint.a);
    glUniform1i(asset.shader.ticksUniform, ticks);
    glUniform3f(asset.shader.cameraVectorUniform, screen.cameraVector.x, screen.cameraVector.y, screen.cameraVector.z);

    screen.modelViewMatrix = mmatrix;
    
    [self increaseBufferSize: asset.numVerts];
    [asset verts: _vertBuffer];
    [asset normals: _normalBuffer];
    [asset tverts: _tvertBuffer];
    
    glVertexAttribPointer(shaderVertexAttribute, 3, GL_FLOAT, GL_FALSE, 0, _vertBuffer);
    glVertexAttribPointer(shaderNormalAttribute, 3, GL_FLOAT, GL_FALSE, 0, _normalBuffer);
    glVertexAttribPointer(shaderTVertAttribute, 2, GL_FLOAT, GL_FALSE, 0, _tvertBuffer);
    glBindTexture(GL_TEXTURE_2D, asset.texture.textureId);
    glDrawArrays(asset.numVerts == 4 ? GL_TRIANGLE_STRIP : GL_TRIANGLES, 0, asset.numVerts);
  }

  glDisableVertexAttribArray(shaderVertexAttribute);
  glDisableVertexAttribArray(shaderTVertAttribute);
  glDisableVertexAttribArray(shaderNormalAttribute);
}

- (void) increaseBufferSize:(NSUInteger) numverts {
  if(_buffersize >= numverts) return;
  
  _buffersize = numverts;
  
  if(_vertBuffer) free(_vertBuffer);
  if(_normalBuffer) free(_normalBuffer);
  if(_tvertBuffer) free(_tvertBuffer);

  _vertBuffer = (GLfloat *)malloc(sizeof(vec3) * numverts);
  _normalBuffer = (GLfloat *)malloc(sizeof(vec3) * numverts);
  _tvertBuffer = (GLfloat *)malloc(sizeof(vec2) * numverts);
}

- (void) renderView:(KZView *) v {
  KZShader *shader = [KZShader defaultShader];
  KZScreen *screen = [KZScreen shared];
  
  GLfloat tverts[] = { 0, 0, 1, 0, 0, 1, 1, 1 };
  GLfloat verts[12] = {0};
  [v verts:verts];
  
  [shader activate];
  
  glDisable(GL_DEPTH_TEST);
  glEnableVertexAttribArray(shaderVertexAttribute);
  glEnableVertexAttribArray(shaderTVertAttribute);
  glVertexAttribPointer(shaderVertexAttribute, 3, GL_FLOAT, GL_FALSE, 0, verts);
  glVertexAttribPointer(shaderTVertAttribute, 2, GL_FLOAT, GL_FALSE, 0, tverts);

  glUniformMatrix4fv(shader.modelViewProjectionMatrixUniform, 1, 0, screen.uiMatrix.m);
  glUniform4f(shader.tintUniform, v.tint.r, v.tint.g, v.tint.b, v.tint.a);
  glBindTexture(GL_TEXTURE_2D, v.texture.textureId);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  
  glDisableVertexAttribArray(shaderVertexAttribute);
  glDisableVertexAttribArray(shaderTVertAttribute);
  
  for(KZView *subview in v.subviews) [self renderView: subview];
}

- (void) renderMesh:(KZMesh *) m offset:(vec3) offset {
  
}

- (void) renderSprite:(KZSprite *) s offset:(vec3) offset {
  
}

@end
