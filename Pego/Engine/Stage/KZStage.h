//
//  GLViewController.h
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "KezziEngine.h"
#import "KZScene.h"
@class KZCamera, KZEntity, KZView, KZRenderer, Stack, KZScene, KZSound;
@interface KZStage : GLKViewController <UIAccelerometerDelegate>
@property (strong, nonatomic) KZView *background;
@property (retain, nonatomic) EAGLContext *context;
@property (retain, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) NSMutableArray *entities;
@property (nonatomic) NSUInteger ticks;

- (id) initWithRootScene:(KZScene *) scene;
- (void) pushScene:(KZScene *)scene;
- (void) popScene;
+ (KZStage *) stage;
- (KZScene *) scene;
- (void) addEntity:(KZEntity *) entity;
- (void) addEntities:(NSArray *) entities;
- (void) removeEntity:(KZEntity *) entity;
- (void) removeAllEntities;
- (void) didBecomeActive;
- (GLKView *) glkView;

- (void) playSound: (NSString *) name;
- (void) loopMusic:(NSString *) name;
- (void) stopMusic;
- (void) stopSounds;


@end
