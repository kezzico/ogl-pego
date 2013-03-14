//
//  Scene.h
//  PenguinCross
//
//  Created by Lee Irvine on 12/22/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//
#import "KezziEngine.h"
@class KZCamera, KZView, KZStage;
@interface KZScene : NSObject
@property (nonatomic, strong) KZCamera *camera;
@property (nonatomic, strong) NSMutableArray *views;

- (void) update;
- (void) sceneWillBegin;
- (void) sceneWillResume;
- (void) didDoubleTouch;
- (void) didReleaseDoubleTouch;
- (void) didTouchAtPosition:(vec3) p;
- (void) didReleaseTouch;
- (void) addView:(KZView *) view;
- (void) removeAllViews;
-(void) didTilt: (float) tilt;
- (KZStage *) stage;
@end
