//
//  Scene.m
//  PenguinCross
//
//  Created by Lee Irvine on 12/22/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZScene.h"
#import "KZStage.h"

@implementation KZScene

- (id) init {
  if(self = [super init]) {
    self.views = [NSMutableArray array];
    
    CGFloat height = 768.f;
    CGSize screensize = UIScreen.mainScreen.bounds.size;
    CGFloat width = (screensize.width / screensize.height) * height;
    
    self.projectionMatrix = GLKMatrix4MakeOrtho(0, width, height, 0, -20, 21);
    [self pan:_v(0, 0, 1)];
  }
  
  return self;
}

- (void) pan:(vec3) p {
  CGFloat scale = UIScreen.mainScreen.scale;
  CGSize screenSize = UIScreen.mainScreen.bounds.size;
  p.x = p.x - (scale * screenSize.width / 2.f);
  p.y = p.y - (scale * screenSize.height / 2.f);
  self.viewMatrix = GLKMatrix4MakeLookAt(p.x, p.y, p.z, p.x, p.y, p.z - 1, 0, 1, 0);
}


- (void) addView:(KZView *) view {
  [self.views addObject:view];
}

- (void) removeView:(KZView *) view {
  [self.views removeObject: view];
}

- (void) removeAllViews {
  [self.views removeAllObjects];
}

- (void) addViewToBottom:(KZView *)view {
  [self.views insertObject:view atIndex:0];
}

- (KZStage *) stage {
  return [KZStage stage];
}

- (void) update { }
- (void) sceneWillBegin { }
- (void) sceneWillEnd { }
- (void) sceneWillResume { }
- (void) sceneWillPause { }

- (void) didDoubleTouch { }
- (void) didReleaseDoubleTouch { }
- (void) didTouchAtPosition:(vec3) p { }
- (void) didReleaseTouch { }
-(void) didTilt: (float) tilt {}
@end
