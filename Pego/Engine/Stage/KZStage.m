//
//  GLViewController.m
//  PenguinCross
//
//  Created by Lee Irvine on 7/15/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <TargetConditionals.h>
#import "KZStage.h"
#import "KZScreen.h"
#import "KZRenderer.h"
#import "Stack.h"
#import "KZScene.h"
#import "OALSimpleAudio.h"
#import "KZAsset.h"

static KZStage *stage;

@interface KZStage ()
@property (strong, nonatomic) KZRenderer *renderer;
@property (strong, nonatomic) KZView *touchedView;
@property (strong, nonatomic) Stack *scenes;
@property (strong, nonatomic) OALSimpleAudio *speaker;

@end

@implementation KZStage
+ (KZStage *) stage {
  return stage;
}

- (void) dealloc {
  stage = nil;
}

- (void) loadView {
  self.view = [[self.viewClass alloc] initWithFrame:UIScreen.mainScreen.bounds];
  self.glview.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
}

- (GLKView *) glview {
  return (GLKView *)self.view;
}

- (Class) viewClass {
  return GLKView.class;
}

- (id) initWithRootScene:(KZScene *) scene {
  if((self = stage = [super init])) {
    self.scenes = [[Stack alloc] init];
    self.renderer = [[KZRenderer alloc] init];
    self.entities = [NSMutableArray arrayWithCapacity:256];
    self.events = [NSMutableArray arrayWithCapacity:16];
    self.speaker = [OALSimpleAudio sharedInstance];
    [self.scenes push: scene];
  }
  
  return self;
}

- (void) viewDidLoad {
  [super viewDidLoad];
  [self setupAudio];
  [self setupGLContext];
  [self.renderer setup];
  [self pushScene: [self.scenes pop]];
}

- (void) setupAudio {
  [OALSimpleAudio sharedInstance].allowIpod = NO;
  [OALSimpleAudio sharedInstance].honorSilentSwitch = YES;
}

- (void) setupGLContext {
  self.preferredFramesPerSecond = 30;
  self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  self.glkView.context = self.context;
  self.glkView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
#ifndef TARGET_IPHONE_SIMULATOR
  self.glkView.drawableMultisample = GLKViewDrawableMultisample4X;
#endif
  
  [EAGLContext setCurrentContext:self.context];

}

- (GLKView *) glkView {
  return (GLKView*)self.view;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  [self.renderer clear];
  [[KZScreen shared] lookAt: self.scene.camera];  
  
  NSArray *sortedEntities = [_entities sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"renderPriority" ascending:YES]]];
  
  for(KZEntity *e in sortedEntities) {
    [self.renderer renderEntity: e];
  }
  
  for(KZView *view in self.scene.views) {
    [self.renderer renderView: view];
  }
}

- (void) update {
  if(self.isPaused) return;
  
  for(KZEntity *e in _entities) [e update];
  [self runEventsForTick: _ticks];
  [self.scene update];
  _ticks++;
}

- (void) runEventsForTick:(NSUInteger) tick {
  NSArray *events = [NSArray arrayWithArray: self.events];
  for(KZEvent *e in events) {
    if(tick < e.nextTick) continue;
    e.action();
    e.isRepeating ?
      [e calculateNextTick] :
      [e cancel];
  }
}

- (void) pushScene:(KZScene *) scene {
  [[self.scenes peek] sceneWillPause];
  [self.scenes push: scene];
  [self.scene sceneWillBegin];
}

- (void) popScene {
  [[self.scenes peek] sceneWillEnd];
  [self.scenes pop];
  [self.scene sceneWillResume];
}

- (KZScene *) scene {
  return [self.scenes peek];
}

- (void) addEntity:(KZEntity *) entity {
  [self.entities addObject:entity];
}
- (void) addEntities:(NSArray *) entities {
  [self.entities addObjectsFromArray:entities];
}
- (void) removeEntity:(KZEntity *) entity {
  [self.entities removeObject:entity];
}
- (void) removeAllEntities {
  [self.entities removeAllObjects];
}

#pragma mark touch delegate

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  CGPoint t = [[touches anyObject] locationInView:self.view];
  self.touchedView = [self viewForTouch: t in: self.scene.views];
  
  if(self.touchedView != nil) {
    [self.touchedView didTouchDown];
    return;
  }
  
  if([self.scene respondsToSelector:@selector(didTouchAtPosition:)]) {
    vec3 p = [[KZScreen shared] mapTouchPointToScene: t];
    [self.scene didTouchAtPosition:p];
  }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  if(self.touchedView != nil) {
    CGPoint t = [[touches anyObject] locationInView:self.view];
    [self.touchedView didTouchUp];
    if([self viewForTouch: t in: self.scene.views] == self.touchedView) {
      [self.touchedView didTouchUpInside];
    }
    
    self.touchedView = nil;
    return;
  }
  
  if([self.scene respondsToSelector:@selector(didReleaseTouch)]) {
    [self.scene didReleaseTouch];
  }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  if(self.touchedView != nil) return;
  
  if([self.scene respondsToSelector:@selector(didTouchAtPosition:)]) {
    CGPoint t = [[touches anyObject] locationInView:self.view];
    vec3 p = [[KZScreen shared] mapTouchPointToScene: t];
    [self.scene didTouchAtPosition:p];
  }
}

- (KZView *) viewForTouch:(CGPoint) t in:(NSArray *) views {
  // aspect is height over width because they are reversed in kzscreen
  CGFloat aspect = KZScreen.shared.height / UIScreen.mainScreen.bounds.size.height;
  CGPoint t_aspect = CGPointMake(t.x * aspect, t.y * aspect);
  
  for(KZView *view in views) {
    if(CGRectContainsPoint(view.rect, t_aspect) == NO) continue;
    if([view.subviews count] == 0 && view.touchTarget == nil) continue;
    
    KZView *touchedChildView = [self viewForTouch:t in: view.subviews];
    return touchedChildView == nil ? view : touchedChildView;
  }
  
  return nil;
}

- (void) playSound:(NSString *) name {
  NSString *file = [name stringByAppendingString:@".mp3"];
  [self.speaker playEffect: file];
}

- (void) loopMusic:(NSString *) name {
  [self.speaker playBg: name loop:YES];
}

- (void) stopMusic {
  [self.speaker stopBg];
}

-(void) stopSounds {
  [self.speaker stopAllEffects];
}

@end
