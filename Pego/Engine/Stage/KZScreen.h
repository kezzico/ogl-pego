//
//  Screen.h
//  Pego
//
//  Created by Lee Irvine on 12/23/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  KZScreenModePerspective,
  KZScreenModeOrtho
} KZScreenMode;

@class KZCamera;
@interface KZScreen : NSObject
@property (nonatomic, assign) vec3 cameraVector;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (nonatomic, assign) GLKMatrix4 modelViewMatrix;
@property (nonatomic, assign) GLKMatrix4 uiMatrix;
@property (nonatomic, assign) KZScreenMode screenMode;
+ (KZScreen *) shared;
+ (void) setupScreen:(KZScreenMode) mode;
- (void) translate:(vec3) p;
- (void) rotate:(vec3) p angle:(float) angle;
- (void) lookAt:(KZCamera *) camera;
- (GLfloat) aspect;
- (GLfloat) fovy;
- (GLfloat) width;
- (GLfloat) height;
- (GLKMatrix4) modelViewProjectionMatrix;
- (vec3) mapTouchPointToScene: (CGPoint) p;
- (GLKMatrix3) normalMatrix;
- (NSInteger) maxZ;
- (NSInteger) minZ;
@end
