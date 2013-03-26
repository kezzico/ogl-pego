//
//  Entity.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZEntity.h"
#import "KZSprite.h"

@implementation KZEntity

+ (KZEntity *) entity:(NSArray *) assets {
  KZEntity *entity = [[KZEntity alloc] init];
  entity.assets = assets;
  
  return entity;
}

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

- (void) setAngle_z:(float) angle {
  _angle.z = angle;
}
- (void) setAngle_y:(float) angle {
  _angle.y = angle;
}
- (void) setAngle_x:(float) angle {
  _angle.x = angle;
}
@end
