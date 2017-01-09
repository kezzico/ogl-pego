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

@interface KZScreen : NSObject
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (nonatomic, assign) GLKMatrix4 viewMatrix;
@property (nonatomic, assign) GLKMatrix4 uiMatrix;
@property (nonatomic, assign) KZScreenMode screenMode;

+ (KZScreen *) shared;
+ (void) setupScreen:(KZScreenMode) mode;
- (GLfloat) aspect;
- (GLfloat) fovy;
- (GLfloat) width;
- (GLfloat) height;
- (vec3) mapTouchPointToScene: (CGPoint) p;
- (NSInteger) maxZ;
- (NSInteger) minZ;
@end
