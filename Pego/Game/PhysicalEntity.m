//
//  PhysicalEntity.m
//  Pego
//
//  Created by Lee Irvine on 3/23/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "PhysicalEntity.h"

@implementation PhysicalEntity

- (BOOL) isTouching:(KZEntity *) e {
  BOOL isPhysical = [[e class] isSubclassOfClass: [PhysicalEntity class]];
  if(isPhysical == NO) return [super isTouching: e];
  
  PhysicalEntity *a = (PhysicalEntity *) e;
  PhysicalEntity *b = self;
  
  static NSInteger sequence[36] = {
    0,1,0,1,
    0,1,0,2,
    0,1,1,2,
    
    0,1,0,1,
    0,2,0,2,
    0,2,1,2,

    1,2,0,1,
    1,2,0,2,
    1,2,1,2
  };

  vec3 averts[3]; [a verts: averts];
  vec3 bverts[3]; [b verts: bverts];
  
  // check for edge overlap
  
  for(NSInteger i=0;i<34;i+=4) {
    BOOL intersect = doSegmentsIntersect(
      _l(averts[sequence[i+0]], averts[sequence[i+1]]),
      _l(bverts[sequence[i+2]], bverts[sequence[i+3]]));
    
    if(intersect) return YES;
  }
  
  // check if a single point is contained within either triangle
  if(isPointInTriangle(bverts[0], _t(averts[0], averts[1], averts[2]))) {
    return YES;
  }

 if(isPointInTriangle(averts[0], _t(bverts[0], bverts[1], bverts[2]))) {
    return YES;
  }
  
  return NO;
}

- (void) verts:(vec3 *) buffer {
  buffer[0] = rotate(add(self.origin, _bounds.a), self.origin, self.angle);
  buffer[1] = rotate(add(self.origin, _bounds.b), self.origin, self.angle);
  buffer[2] = rotate(add(self.origin, _bounds.c), self.origin, self.angle);
}

- (void) sides:(line *) buffer {
  vec3 v[3]; [self verts: v];
  buffer[0] = _l(v[0], v[1]);
  buffer[1] = _l(v[0], v[2]);
  buffer[2] = _l(v[1], v[2]);
}

- (void) update {
  [super update];
  
  self.lastAngle = self.angle.z;
  [self setAngle_z: self.angle.z + self.angleVector];
}

@end
