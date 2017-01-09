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

@end

@implementation KZCamera

+ (KZCamera *) eye:(vec3) eye {
  KZCamera *camera = [[KZCamera alloc] init];
  [camera eye:eye];
  
  return camera;
}

+ (KZCamera *) camera {
  return [[KZCamera alloc] init];
}

- (void) eye:(vec3)eye {
  CGFloat scale = UIScreen.mainScreen.scale;
  CGSize screenSize = UIScreen.mainScreen.bounds.size;
  eye.x = eye.x - (scale * screenSize.width / 2.f);
  eye.y = eye.y - (scale * screenSize.height / 2.f);
  self.viewMatrix = GLKMatrix4MakeLookAt(eye.x, eye.y, eye.z, eye.x, eye.y, eye.z - 1, 0, 1, 0);
}

//- (GLKMatrix4) viewMatrix {
//  vec3 eye = self.eye, origin = self.origin, up = self.up;
//  
//  return GLKMatrix4MakeLookAt(eye.x, eye.y, eye.z, origin.x, origin.y, origin.z, up.x, up.y, up.z);
//}

@end
