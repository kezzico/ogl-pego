//
//  Mesh.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZMesh.h"
#import "KZAnimation.h"
#import "NSDictionary-Extensions.h"

@interface CachedMesh : NSObject
@property (nonatomic) NSUInteger numFrames;
@property (nonatomic) NSUInteger numFaces;
@property (nonatomic) NSUInteger numVerts;
@property (nonatomic) GLfloat *verts;
@property (nonatomic) GLfloat *normals;
@property (nonatomic) GLfloat *tverts;
@end

@implementation CachedMesh
- (void) dealloc {
  if(_verts) free(_verts);
  if(_normals) free(_normals);
  if(_tverts) free(_tverts);
  
  _verts = 0;
  _normals = 0;
  _tverts = 0;
}

- (void) loadFromData: (NSData *) data {
  __block NSUInteger lastRangeLocation = 0;
  NSRange(^nextRange)(NSUInteger) = ^NSRange (NSUInteger n) {
    NSRange output = NSMakeRange(lastRangeLocation, n);
    lastRangeLocation += n;
    return output;
  };
  
  [data getBytes:&_numFrames range: nextRange(sizeof(NSUInteger))];
  [data getBytes:&_numFaces range: nextRange(sizeof(NSUInteger))];
  _numVerts = _numFaces * 3;
  
  NSUInteger vertDataSize = sizeof(GLfloat) * _numVerts * _numFrames * 3;
  NSUInteger normalDataSize = sizeof(GLfloat) * _numVerts * 3;
  NSUInteger tvertDataSize = sizeof(GLfloat) * _numVerts * 2;
  
  _verts = (GLfloat *)malloc(vertDataSize);
  _normals = (GLfloat *)malloc(normalDataSize);
  _tverts = (GLfloat *)malloc(tvertDataSize);
  
  [data getBytes:_verts range: nextRange(vertDataSize)];
  [data getBytes:_normals range: nextRange(normalDataSize)];
  [data getBytes:_tverts range: nextRange(tvertDataSize)];
}

@end

@interface KZMesh ()
@property (nonatomic, strong) CachedMesh *mesh;
@end

@implementation KZMesh

- (NSUInteger) numVerts {
  return self.mesh.numVerts;
}

- (void) normals: (GLfloat *) buffer {
  memcpy(buffer, self.mesh.normals, sizeof(vec3) * _mesh.numVerts);
}
- (void) tverts: (GLfloat *) buffer {
  memcpy(buffer, self.mesh.tverts, sizeof(vec2) * _mesh.numVerts);
}

- (void) verts: (GLfloat *) buffer {
  GLfloat *verts = _mesh.verts + (self.numVerts * self.animation.frame * 3);
  memcpy(buffer, verts, sizeof(vec3) * _mesh.numVerts);
}

+ (KZMesh *) meshWithName:(NSString *) name {
  NSMutableDictionary *cache = [NSDictionary cacheWithName:@"mesh"];
  CachedMesh *cm = [cache valueForKey:name];
  
  if(cm == nil) {
    NSString *meshPath = [[NSBundle mainBundle] pathForResource:name ofType:@"mesh"];
    NSData *data = [NSData dataWithContentsOfFile:meshPath];
    cm = [[CachedMesh alloc] init];
    [cm loadFromData: data];
    [cache setValue:cm forKey:name];
  }
  
  KZMesh *m = [[KZMesh alloc] init];
  m.animation = [[KZAnimation alloc] init];
  m.tint = _c(1, 1, 1, 1);
  m.mesh = cm;
  
  return m;
}

@end
