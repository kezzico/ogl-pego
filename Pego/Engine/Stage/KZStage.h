//
//  GLViewController.h
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "KezziEngine.h"
#import "KZScene.h"
@class KZCamera, KZEntity, KZView, KZRenderer, Stack, KZScene, KZSound;
@interface KZStage : GLKViewController <UIAccelerometerDelegate>
@property (retain, nonatomic) EAGLContext *context;
@property (retain, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) NSMutableArray *entities;
@property (nonatomic) NSUInteger ticks;
@property (nonatomic) BOOL isPaused;
- (id) initWithRootScene:(KZScene *) scene;
- (void) pushScene:(KZScene *)scene;
- (void) popScene;
+ (KZStage *) stage;
- (KZScene *) scene;
- (void) addEntity:(KZEntity *) entity;
- (void) addEntities:(NSArray *) entities;
- (void) removeEntity:(KZEntity *) entity;
- (void) removeAllEntities;
- (GLKView *) glkView;

- (void) playSound: (NSString *) name;
- (void) loopMusic:(NSString *) name;
- (void) stopMusic;
- (void) stopSounds;

@end
