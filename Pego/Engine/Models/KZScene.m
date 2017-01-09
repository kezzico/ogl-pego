//
//  Scene.m
//  PenguinCross
//
//  Created by Lee Irvine on 12/22/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZScene.h"
#import "KZStage.h"

@implementation KZScene

- (id) init {
  if(self = [super init]) {
    self.views = [NSMutableArray array];
    self.camera = [KZCamera eye: _v(0,0,1)];
  }
  return self;
}

- (void) dealloc {
  if(_vertBuffer) free(_vertBuffer);
  if(_normalBuffer) free(_normalBuffer);
  if(_tvertBuffer) free(_tvertBuffer);
}

- (void) sceneWillBegin {
  glEnable(GL_BLEND);
  glEnable(GL_CULL_FACE);
  glCullFace(GL_BACK);
  glActiveTexture (GL_TEXTURE0);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glClearColor(.5f,.5f,.5f,1.f);

  self.projectionMatrix = GLKMatrix4MakeOrtho(0, self.width, self.height, 0, self.minZ, self.maxZ+1);
  self.viewMatrix = GLKMatrix4Identity;
  glDisable(GL_DEPTH_TEST);
}

- (void) clear {
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

- (void) renderEntity:(KZEntity *) e {
  NSUInteger ticks = [[KZStage stage] ticks];
  
  glEnable(GL_DEPTH_TEST);
  glEnableVertexAttribArray(shaderVertexAttribute);
  glEnableVertexAttribArray(shaderTVertAttribute);
  glEnableVertexAttribArray(shaderNormalAttribute);
  
  GLKMatrix4 projectionMatrix = self.projectionMatrix;
  GLKMatrix4 viewMatrix = self.viewMatrix;
  
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
/////////////////////////////////////////

- (void) addView:(KZView *) view {
  [self.views addObject:view];
}

- (void) removeView:(KZView *) view {
  [self.views removeObject: view];
}

- (void) removeAllViews {
  [self.views removeAllObjects];
}

- (void) addViewToBottom:(KZView *)view {
  [self.views insertObject:view atIndex:0];
}

- (KZStage *) stage {
  return [KZStage stage];
}

- (void) update { }
- (void) sceneWillEnd { }
- (void) sceneWillResume { }
- (void) sceneWillPause { }

- (void) didDoubleTouch { }
- (void) didReleaseDoubleTouch { }
- (void) didTouchAtPosition:(vec3) p { }
- (void) didReleaseTouch { }
-(void) didTilt: (float) tilt {}
@end
