//
//  KZRectangle.m
//  Pego
//
//  Created by Lee Irvine on 3/17/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZRectangle.h"
@interface KZRectangle () {
  float _width, _height;
}
@property (nonatomic) vec3 topleft;
@property (nonatomic) vec3 topright;
@property (nonatomic) vec3 botleft;
@property (nonatomic) vec3 botright;
@end

@implementation KZRectangle

+ (KZRectangle *) rectangle:(rect) rect {
  KZRectangle *rectangle = [[KZRectangle alloc] init];
  rectangle.tint = _c(1, 1, 1, 1);
  rectangle.shader = [KZShader defaultShader];
  rectangle.texture = [KZTexture textureWithName:@"white"];
  
  rectangle->_width = fabsf(rect.bottomright.x - rect.topleft.x);
  rectangle->_height = fabsf(rect.bottomright.y - rect.topleft.y);
  
  rectangle.topleft = rect.topleft;
  rectangle.botright = rect.bottomright;
  rectangle.topright = add(rect.topleft, _v(rectangle->_width, 0, 0));
  rectangle.botleft = add(rect.topleft, _v(0, rectangle->_height, 0));
  
  return rectangle;
}

- (float) width {
  return _width;
}
- (float) height {
  return _height;
}

- (KZAnimation *) animation {
  return nil;
}

- (NSUInteger) numVerts {
  return 4;
}

- (void) tverts:(GLfloat *) buffer {
  GLfloat box[] = { 0, 0, 1, 0, 0, 1, 1, 1 };
  memcpy(buffer, box, sizeof(box));
}

- (void) verts: (GLfloat *) buffer {
  vec3 *vbuffer = (vec3 *)buffer;
  vbuffer[0] = self.botleft;
  vbuffer[1] = self.botright;
  vbuffer[2] = self.topleft;
  vbuffer[3] = self.topright;
}

- (void) normals: (GLfloat *) buffer {
  for(NSInteger i=0;i<12;i++) buffer[i] = 1.f;
}

@end
