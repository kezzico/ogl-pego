//
//  Renderer.h
//  Pego
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KZView;
@class KZEntity;
@interface KZRenderer : NSObject {
  NSUInteger _buffersize;
  GLfloat *_vertBuffer;
  GLfloat *_normalBuffer;
  GLfloat *_tvertBuffer;
}

- (void) setup;
- (void) clear;
- (void) renderEntity:(KZEntity *) e;
- (void) renderView:(KZView *) v;
- (void) renderMesh:(KZMesh *) m offset:(vec3) offset;
- (void) renderSprite:(KZSprite *) s offset:(vec3) offset;
@end
