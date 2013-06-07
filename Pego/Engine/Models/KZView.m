//
//  View.m
//  PenguinCross
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <objc/message.h>
#import "KZView.h"
#import "KZScreen.h"

@implementation KZView
// TODO: add support for text to views
+ (KZView *) viewWithPosition:(float) x :(float) y size:(float)width : (float)height {
  KZView *view = [[KZView alloc] init];
  view.x = x;
  view.y = y;
  view.width = width;
  view.height = height;
  view.tint = _c(1, 1, 1, 1);
  
  return view;
}

+ (KZView *) fullscreen {
  GLfloat width = [[KZScreen shared] width], height = [[KZScreen shared] height];
  return [KZView viewWithPosition:0 :0 size:width :height];
  
}

- (void) addSubview:(KZView *) subview {
  if(_subviews == nil) {
    self.subviews = [NSMutableArray array];
  }
  
  [self.subviews addObject: subview];
  subview.superview = self;
}

- (void) removeFromSuperview {
  self.superview = nil;
  [self.superview.subviews removeObject:self];
}

- (CGRect) rect {
  return CGRectMake(_x, _y, _width, _height);
}

- (void) sendTouchAction:(SEL) action to:(id) target {
  self.touchTarget = target;
  self.touchAction = action;
}

- (void) didTouchDown {
  _isHighlit = YES;
}

- (void) didTouchUp {
  _isHighlit = NO;
}

- (void) didTouchUpInside {
  if(self.touchTarget == nil) return;
  objc_msgSend(self.touchTarget, self.touchAction);
}

- (KZTexture *) texture {
  return _isHighlit && self.highlightTexture ? self.highlightTexture : self.defaultTexture;
}

- (void) verts: (GLfloat *) buffer {
  vec3 box[4];
  box[0] = _v(0, _height, 0);
  box[1] = _v(_width, _height, 0);
  box[2] = _v(0,0,0);
  box[3] = _v(_width,0,0);

  memcpy(buffer, box, sizeof(box));
}

- (void) tverts: (GLfloat *) buffer {
  GLfloat tverts[] = { 0, 0, 1, 0, 0, 1, 1, 1 };
  memcpy(buffer, tverts, sizeof(tverts));
}

- (NSInteger) numVerts {
  return 4;
}

@end
