//
//  SurfaceEntity.m
//  Pego
//
//  Created by Lee Irvine on 6/3/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Surface.h"

static vec3 shadowoffset = _v(-8, 6, 0);
@implementation Surface

+ (Surface *) spawnRockWithTriangle:(tri) t {
  Surface *rock = [[Surface alloc] init];
  [rock setupSurface: t];
  
  rock.mass = INFINITY;
  rock.color = [Surface randomRockColor];
  rock.canMelt = NO;
  
  return rock;
}

+ (Surface *) spawnIceWithTriangle:(tri) t {
  Surface *ice = [[Surface alloc] init];
  [ice setupSurface:t];
  ice.color = [Surface randomIceColor];
  
  ice.mass = areaOfTriangle(t) * 0.0002 + 0.3f;
  
  ice.canMelt = YES;
  ice.didMelt = NO;
  
  return ice;
}

- (void) setupSurface:(tri) t {
  tri nt = [self normalizeTriangle: t];
  
  self.origin = centerOfTriangle(t);
  self.bounds = nt;
  self.triangle = [KZTriangle triangle: nt];
  self.shadow = [KZTriangle triangle: nt];
  self.assets = @[self.triangle, self.shadow];
  
  self.triangle.zIndex = 7;
  self.shadow.zIndex = 6;
  
  self.shadow.offset = shadowoffset;
  self.mass = 1.f;
  self.renderPriority = 1;
  self.opacity = 1.f;
}

- (void) setOpacity:(float) opacity {
  self.triangle.tint = _c(self.color.r,self.color.g,self.color.b, opacity);
  self.shadow.tint = _c(.03f,.05f,.18f, opacity);
}

- (void) setColor:(rgba)color {
  _color = color;
  self.opacity = color.a;
}

- (float) opacity {
  return self.triangle.tint.a;
}

+ (rgba) randomIceColor {
  float m = 255.f;
  rgba colors[] = {
    _c(255.f/m, 255.f/m, 255.f/m,1.f),
    _c(255.f/m, 255.f/m, 255.f/m,1.f),
    _c(255.f/m, 255.f/m, 255.f/m,1.f),
    _c(225.f/m, 243.f/m, 255.f/m,1.f),
    _c(225.f/m, 243.f/m, 255.f/m,1.f),
    _c(168.f/m, 205.f/m, 226.f/m,1.f),
    _c(168.f/m, 205.f/m, 226.f/m,1.f),
    _c(100.f/m, 139.f/m, 160.f/m,1.f),
    _c(149.f/m, 193.f/m, 214.f/m,1.f)
  };
  
  return colors[arc4random() % (sizeof(colors) / sizeof(colors[0]))];
}

+ (rgba) randomRockColor {
  float m = 255.f;
  rgba colors[] = {
    _c(160.f/m,  160.f/m,  160.f/m,1.f),
    _c(146.f/m,  146.f/m,  146.f/m,1.f),
    _c(128.f/m,  128.f/m,  128.f/m,1.f),
    _c(112.f/m,  112.f/m,  112.f/m,1.f),
    _c(96.f/m,   96.f/m,   96.f/m, 1.f)
  };
  
  return colors[arc4random() % (sizeof(colors) / sizeof(colors[0]))];
}

- (tri) normalizeTriangle:(tri) t {
  vec3 origin = centerOfTriangle(t);
  tri nt;
  
  nt.a = sub(t.a, origin);
  nt.b = sub(t.b, origin);
  nt.c = sub(t.c, origin);
  
  return nt;
}

@end
