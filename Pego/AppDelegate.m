//  AppDelegate.m
//  Kezzi-Engine
//
//  Created by Lee Irvine on 7/14/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "AppDelegate.h"
#import "GameScene.h"
#import "KezziEngine.h"
#import "KZScreen.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [KZScreen setupScreen];
  KZScene *scene = [[GameScene alloc] init];
  
  self.stage = [[KZStage alloc] initWithRootScene: scene];
  self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
  self.window.rootViewController = self.stage;
  [self.window makeKeyAndVisible];
  
  return YES;
}


@end
