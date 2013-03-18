//
//  LogoScene.m
//  Pego
//
//  Created by Lee Irvine on 3/10/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "SplashScene.h"
#import "KezziEngine.h"
#import "MenuScene.h"

@implementation SplashScene
- (void) sceneWillBegin {
  KZView *splash = [KZView viewWithPosition:0 :0 size:1024 :768];
  splash.defaultTexture = [KZTexture textureWithName:@"splashlogo"];
  [self addView:splash];

  [KZEvent after:.3f run:^{
    MenuScene *menu = [[MenuScene alloc] init];
    [self.stage popScene];
    [self.stage pushScene: menu];
  }];
}

@end
