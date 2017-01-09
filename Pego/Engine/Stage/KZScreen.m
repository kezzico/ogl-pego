//
//  Screen.m
//  Pego
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZScreen.h"
#import "glUnproject.h"

static KZScreen *sharedScreen;
@implementation KZScreen

+ (void) setupScreen:(KZScreenMode) mode {
  sharedScreen = [[KZScreen alloc] init];
  [sharedScreen setupUiMatrix];
  
  sharedScreen.screenMode = mode;
  if(mode == KZScreenModePerspective) {
    [sharedScreen setupActionMatrixPerspective];
  }
  
  if(mode == KZScreenModeOrtho) {
    [sharedScreen setupActionMatrixOrtho];
  }
}

+ (KZScreen *) shared {  
  return sharedScreen;
}

- (void) setupActionMatrixPerspective {
  self.projectionMatrix = GLKMatrix4MakePerspective(self.fovy, self.aspect, 10, 1000);
  self.viewMatrix = GLKMatrix4Identity;
  glEnable(GL_DEPTH_TEST);
}

- (void) setupActionMatrixOrtho {
  self.projectionMatrix = GLKMatrix4MakeOrtho(0, self.width, self.height, 0, self.minZ, self.maxZ+1);
  self.viewMatrix = GLKMatrix4Identity;
  glDisable(GL_DEPTH_TEST);
}

- (GLfloat) height {
  return 768;
}

- (GLfloat) width {
  CGSize screensize = UIScreen.mainScreen.bounds.size;
  CGFloat width = (screensize.width / screensize.height) * self.height;
  
  return width;
}

- (NSInteger) maxZ {
  return 20;
}

- (NSInteger) minZ {
  return -20;
}

- (GLfloat) aspect {
  CGRect bounds = UIScreen.mainScreen.bounds;
  return bounds.size.height / bounds.size.width;
}
- (GLfloat) fovy {
  return rads(45.f);
}
- (void) setupUiMatrix {
  GLKMatrix4 projection = GLKMatrix4MakeOrtho(0, self.width, self.height, 0, 0, 1);
  GLKMatrix4 modelview = GLKMatrix4MakeLookAt(0, 0, 1, 0, 0, 0, 0, 1, 0);
  self.uiMatrix = GLKMatrix4Multiply(projection, modelview);
}

- (vec3) mapTouchPointToScene: (CGPoint) p {
  GLint viewport[4];
  glGetIntegerv(GL_VIEWPORT, viewport);
  
  CGFloat s = [[UIScreen mainScreen] scale];
  vec3 v = _v(p.x * s, viewport[3] - p.y * s, 0.f);
  
  vec3 near, far;
  gluUnProject(v.x, v.y, 0, self.viewMatrix.m, self.projectionMatrix.m, viewport, &near.x, &near.y, &near.z);
  gluUnProject(v.x, v.y, 1, self.viewMatrix.m, self.projectionMatrix.m, viewport, &far.x, &far.y, &far.z);
  
  vec3 n = (vec3){0,0,1};
  vec3 onPlane = (vec3){25.f,25.f,0.f};
  
  float u = dot(n, sub(onPlane, far)) / dot(n, sub(near, far));
  vec3 output = add(far, scale(sub(near, far), u));
  
  return output;
}

@end
