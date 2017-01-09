//
//  KZAsset.m
//  Pego
//
//  Created by Lee on 1/8/17.
//  Copyright © 2017 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation KZAsset

- (GLKMatrix4) modelMatrix {
  GLKMatrix4 mmatrix = GLKMatrix4Identity;
  
  vec3 offset = self.offset;
  vec3 angle = self.angle;
  mmatrix = GLKMatrix4Translate(mmatrix, offset.x, offset.y, self.zIndex);
  mmatrix = GLKMatrix4Rotate(mmatrix, angle.x, 1, 0, 0);
  mmatrix = GLKMatrix4Rotate(mmatrix, angle.y, 0, 1, 0);
  mmatrix = GLKMatrix4Rotate(mmatrix, angle.z, 0, 0, 1);
  
  return mmatrix;
}

- (KZAnimation *) animation {
  return nil;
}

- (GLuint) numVerts {
  return 0;
}

- (void) tverts:(GLfloat *) buffer {

}

- (void) verts: (GLfloat *) buffer {

}

- (void) normals: (GLfloat *) buffer {

}


@end