//
//  Camera.m
//  PenguinCross
//
//  Created by Lee Irvine on 12/19/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZCamera.h"
#import "KZScreen.h"
@interface KZCamera ()
@property (nonatomic, assign) vec3 up;
@property (nonatomic, assign) vec3 origin;
@property (nonatomic, assign) vec3 eye;
@property (nonatomic, assign) vec3 tilt;

@end

@implementation KZCamera

+ (KZCamera *) eye:(vec3) eye origin:(vec3) origin {
  KZCamera *camera = [[KZCamera alloc] init];
  [camera eye:eye origin:origin];
  
  return camera;
}

+ (KZCamera *) eye:(vec3) eye {
  KZCamera *camera = [[KZCamera alloc] init];
  [camera eye:eye];
  
  return camera;
}

+ (KZCamera *) camera {
  return [[KZCamera alloc] init];
}

- (void) eye:(vec3)eye origin:(vec3) origin {
  _eye = eye;
  _origin = origin;
  _tilt = normalize(sub(_eye, _origin));
  
  _up = _tilt;
  _up.y *= -1.f;
}

- (void) eye:(vec3)eye {
  self.eye = eye;
  self.origin = sub(eye, _v(0, 0, 1));
  self.up = _v(0,1,0);
}

- (void) zoomToFit:(rect) bounds {
  const float halffovy = [[KZScreen shared] fovy] * 0.5f;
  const float aspect = [[KZScreen shared] aspect];
  float height = rectheight(bounds);
  float width = rectwidth(bounds);
  float ty = height / (2 * tanf(halffovy));
  float tx = width / (2 * tanf(halffovy * aspect));
  vec3 center = midpoint(bounds.topleft, bounds.bottomright);
  
  _eye = add(scale(_tilt, ty > tx ? ty : tx), center);
  _origin = center;
}
- (GLKMatrix4) viewMatrix {
  vec3 eye = self.eye, origin = self.origin, up = self.up;
  
  return GLKMatrix4MakeLookAt(eye.x, eye.y, eye.z, origin.x, origin.y, origin.z, up.x, up.y, up.z);
}

@end
