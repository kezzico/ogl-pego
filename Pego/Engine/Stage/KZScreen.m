//
//  Screen.m
//  Pego
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZScreen.h"
#import "KZCamera.h"
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
  self.modelViewMatrix = GLKMatrix4Identity;
  glEnable(GL_DEPTH_TEST);
}

- (void) setupActionMatrixOrtho {
  CGRect bounds = [[UIScreen mainScreen] bounds];
  self.projectionMatrix = GLKMatrix4MakeOrtho(0, bounds.size.height, bounds.size.width, 0, 0, 10);
  self.modelViewMatrix = GLKMatrix4Identity;
  glDisable(GL_DEPTH_TEST);
}

- (GLfloat) aspect {
  CGRect bounds = [[UIScreen mainScreen] bounds];
  return bounds.size.height / bounds.size.width;
}
- (GLfloat) fovy {
  return rads(45.f);
}
- (void) setupUiMatrix {
  CGRect bounds = [[UIScreen mainScreen] bounds];
  GLKMatrix4 projection = GLKMatrix4MakeOrtho(0, bounds.size.height, bounds.size.width, 0, 0, 1);
  GLKMatrix4 modelview = GLKMatrix4MakeLookAt(0, 0, 1, 0, 0, 0, 0, 1, 0);
  self.uiMatrix = GLKMatrix4Multiply(projection, modelview);
}

- (GLKMatrix4) modelViewProjectionMatrix {
  return GLKMatrix4Multiply(_projectionMatrix, _modelViewMatrix);
}

- (void) translate:(vec3) p {
  self.modelViewMatrix = GLKMatrix4Translate(_modelViewMatrix, p.x, p.y, p.z);
}

- (void) rotate:(vec3) p angle:(float) angle {
  self.modelViewMatrix = GLKMatrix4Rotate(_modelViewMatrix, angle, p.x, p.y, p.z);
}

- (void) lookAt:(KZCamera *) camera {
  vec3 eye = camera.eye, origin = camera.origin, up = camera.up;
  self.modelViewMatrix = GLKMatrix4MakeLookAt(eye.x, eye.y, eye.z, origin.x, origin.y, origin.z, up.x, up.y, up.z);
  self.cameraVector = sub(eye, origin);
}

- (GLKMatrix3) normalMatrix {
  GLKMatrix3 upperleft = GLKMatrix4GetMatrix3(_modelViewMatrix);
  GLKMatrix3 output = GLKMatrix3Transpose(upperleft);
  return output;
}

- (vec3) mapTouchPointToScene: (CGPoint) p {
  GLint viewport[4];
  glGetIntegerv(GL_VIEWPORT, viewport);
  
  CGFloat s = [[UIScreen mainScreen] scale];
  vec3 v = _v(p.x * s, viewport[3] - p.y * s, 0.f);
  
  vec3 near, far;
  gluUnProject(v.x, v.y, 0, _modelViewMatrix.m, _projectionMatrix.m, viewport, &near.x, &near.y, &near.z);
  gluUnProject(v.x, v.y, 1, _modelViewMatrix.m, _projectionMatrix.m, viewport, &far.x, &far.y, &far.z);
  
  vec3 n = (vec3){0,0,1};
  vec3 onPlane = (vec3){25.f,25.f,0.f};
  
  float u = dot(n, sub(onPlane, far)) / dot(n, sub(near, far));
  vec3 output = add(far, scale(sub(near, far), u));
  
  return output;
}


@end
