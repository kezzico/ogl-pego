//
//  Rect.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Rect.h"

float rectwidth(rect r) {
  return r.topleft.y - r.bottomright.y;
}

float rectheight(rect r) {
  return r.topleft.x - r.bottomright.x;
}

rect insetRect(rect r, float x, float y) {
  rect cr = r;
  cr.topleft.x -= x;
  cr.topleft.y -= y;
  cr.bottomright.x += x;
  cr.bottomright.y += y;
  return cr;
}

BOOL pointInRect(vec3 p, rect r) {
  BOOL below = r.topleft.x > p.x && r.topleft.y > p.y;
  BOOL above = r.bottomright.x > p.x && r.bottomright.y > p.y;
  return above && below;
}

NSString *NSStringFromRect(rect r) {
  NSString *tl = NSStringFromVec3(r.topleft);
  NSString *br = NSStringFromVec3(r.bottomright);
  
  return [NSString stringWithFormat:@"topleft: %@ bottomright: %@", tl, br];
}
