//
//  Scene.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/22/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//
#import "KezziEngine.h"
@class KZCamera, KZView, KZStage;
@interface KZScene : NSObject
@property (nonatomic, strong) KZCamera *camera;
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, assign) GLKMatrix4 viewMatrix;

- (void) update;
- (void) sceneWillBegin;
- (void) sceneWillEnd;
- (void) sceneWillResume;
- (void) sceneWillPause;
- (void) didDoubleTouch;
- (void) didReleaseDoubleTouch;
- (void) didTouchAtPosition:(vec3) p;
- (void) didReleaseTouch;
- (void) addView:(KZView *) view;
- (void) addViewToBottom:(KZView *)view;
- (void) removeView:(KZView *) view;
- (void) removeAllViews;
- (void) didTilt: (float) tilt;
- (KZStage *) stage;
@end
