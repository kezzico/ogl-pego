//
//  Rect.h
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
  vec3 topleft;
  vec3 bottomright;
} rect;

rect insetRect(rect r, float x, float y);
float rectwidth(rect r);
float rectheight(rect r);
NSString* NSStringFromRect(rect r);
BOOL pointInRect(vec3 p, rect r);