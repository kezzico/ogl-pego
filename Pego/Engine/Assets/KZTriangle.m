//
//  KZTriangle.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZTriangle.h"

@interface KZTriangle ()
@property (nonatomic, strong) KZTexture *whiteTexture;
@property (nonatomic, strong) KZShader *defaultShader;
@end

@implementation KZTriangle

+ (KZTriangle *) triangle:(vec3) a : (vec3) b : (vec3) c {
  TriangleDirection rotation = triangleDirection(a, b, c);
  KZTriangle *triangle = [[KZTriangle alloc] init];
  
  if(rotation == TriangleDirectionCounterClockwise) {
    triangle->_va = a;
    triangle->_vb = c;
    triangle->_vc = b;
  } else {
    triangle->_va = a;
    triangle->_vb = b;
    triangle->_vc = c;
  }
  
  triangle.tint = _c(1, 1, 1, 1);
  triangle.defaultShader = [KZShader defaultShader];
  triangle.whiteTexture = [KZTexture textureWithName:@"white"];
  
  return triangle;
}

- (KZAnimation *) animation {
  return nil;
}

- (KZTexture *) texture {
  return _whiteTexture;
}

- (KZShader *) shader {
  return _defaultShader;
}

- (NSUInteger) numVerts {
  return 3;
}

- (void) tverts:(GLfloat *) buffer {
  for(NSInteger i=0;i<6;i++) buffer[i] = 1.f;
}

- (void) verts: (GLfloat *) buffer {
  vec3 *vbuffer = (vec3 *)buffer;
  vbuffer[0] = _va;
  vbuffer[1] = _vb;
  vbuffer[2] = _vc;
}

- (void) normals: (GLfloat *) buffer {
  for(NSInteger i=0;i<9;i++) buffer[i] = 1.f;
}

@end
