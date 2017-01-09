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

- (BOOL) isTouching:(KZEntity *) e {
  float xbuffer = (self.dimensions.x + e.dimensions.x) * .5f;
  float ybuffer = (self.dimensions.y + e.dimensions.y) * .5f;
  float zbuffer = (self.dimensions.z + e.dimensions.z) * .5f;
  
  float xdistance = fabsf(self.dimensions.x - e.dimensions.x);
  float ydistance = fabsf(self.dimensions.y - e.dimensions.y);
  float zdistance = fabsf(self.dimensions.z - e.dimensions.z);
  
  return xbuffer > xdistance && ybuffer > ydistance && zbuffer > zdistance;
}

- (GLKMatrix4) modelMatrix {
  GLKMatrix4 mmatrix = GLKMatrix4Identity;
  vec3 origin = self.origin;
  vec3 angle = self.angle;
  
  mmatrix = GLKMatrix4Translate(mmatrix, origin.x, origin.y, origin.z);
  mmatrix = GLKMatrix4Rotate(mmatrix, angle.x, 1, 0, 0);
  mmatrix = GLKMatrix4Rotate(mmatrix, angle.y, 0, 1, 0);
  mmatrix = GLKMatrix4Rotate(mmatrix, angle.z, 0, 0, 1);
  
  return mmatrix;
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

- (void) update {
  for(id<KZAsset> asset in self.assets) [asset.animation nextFrame];
}
@end
