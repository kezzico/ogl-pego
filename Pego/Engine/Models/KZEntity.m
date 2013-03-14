//
//  Entity.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "KZEntity.h"
#import "KZSprite.h"

@implementation KZEntity

- (NSString *) description {
  NSString *origin = NSStringFromVec3(self.origin);
  return [NSString stringWithFormat:@"Entity: origin:%@", origin];
}

- (BOOL) isMoving {
  return isZerov(_2d(sub(self.lastorigin, self.origin))) == NO;
}

- (BOOL) isTouching:(KZEntity *) e {
  float xbuffer = (self.dimensions.x + e.dimensions.x) * .5f;
  float ybuffer = (self.dimensions.y + e.dimensions.y) * .5f;
  float zbuffer = (self.dimensions.z + e.dimensions.z) * .5f;
  
  float xdistance = fabsf(self.dimensions.x - e.dimensions.x);
  float ydistance = fabsf(self.dimensions.y - e.dimensions.y);
  float zdistance = fabsf(self.dimensions.z - e.dimensions.z);
  
  return xbuffer > xdistance && ybuffer > ydistance && zbuffer > zdistance;
}

- (float) speed {
  return distance(_lastorigin, _origin);
}
@end
