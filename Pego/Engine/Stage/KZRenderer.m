//
//  Renderer.m
//  Pego
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
  glClearColor(.5f,.5f,.5f,1.f);
  
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
  
  glEnable(GL_DEPTH_TEST);
  glEnableVertexAttribArray(shaderVertexAttribute);
  glEnableVertexAttribArray(shaderTVertAttribute);
  glEnableVertexAttribArray(shaderNormalAttribute);

  GLKMatrix4 projectionMatrix = screen.projectionMatrix;
  GLKMatrix4 viewMatrix = screen.viewMatrix;
  
  for(id<KZAsset> asset in e.assets) {
    if(asset.hidden) continue;
    
    GLKMatrix4 mmatrix = GLKMatrix4Multiply(e.modelMatrix, asset.modelMatrix);
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(viewMatrix, mmatrix);
    GLKMatrix4 mvpMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    [asset.shader activate];
    glUniformMatrix4fv(asset.shader.modelViewProjectionMatrixUniform, 1, 0, mvpMatrix.m);
    glUniform4f(asset.shader.tintUniform, asset.tint.r, asset.tint.g, asset.tint.b, asset.tint.a);

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
  GLKMatrix4 mvpm = GLKMatrix4Translate(screen.uiMatrix, v.x, v.y, 0);

  [self increaseBufferSize: v.numVerts];
  [v verts: _vertBuffer];
  [v tverts: _tvertBuffer];
  
  [shader activate];
  
  glDisable(GL_DEPTH_TEST);
  glEnableVertexAttribArray(shaderVertexAttribute);
  glEnableVertexAttribArray(shaderTVertAttribute);
  glVertexAttribPointer(shaderVertexAttribute, 3, GL_FLOAT, GL_FALSE, 0, _vertBuffer);
  glVertexAttribPointer(shaderTVertAttribute, 2, GL_FLOAT, GL_FALSE, 0, _tvertBuffer);

  glUniformMatrix4fv(shader.modelViewProjectionMatrixUniform, 1, 0, mvpm.m);
  glUniform4f(shader.tintUniform, v.tint.r, v.tint.g, v.tint.b, v.tint.a);
  glBindTexture(GL_TEXTURE_2D, v.texture.textureId);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, v.numVerts);
  
  glDisableVertexAttribArray(shaderVertexAttribute);
  glDisableVertexAttribArray(shaderTVertAttribute);
  
  for(KZView *subview in v.subviews) [self renderView: subview];
}

@end
