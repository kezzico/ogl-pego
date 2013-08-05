//
//  SimplePersistence.m
//  Pego
//
//  Created by Lee Irvine on 8/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "SimplePersistence.h"
#import "PondList.h"

@implementation SimplePersistence

+ (NSInteger) lastPondFinished {
  return [[NSUserDefaults standardUserDefaults] integerForKey:@"last-pond-finished"];
}

+ (void) setLastPondFinished:(NSInteger) lastPond {
  NSInteger numberOfLevels = [[PondList shared] numberOfLevels];
  if(lastPond == numberOfLevels) {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"did-finish-game"];
    lastPond = 0;
  }
  

  [[NSUserDefaults standardUserDefaults] setInteger:lastPond forKey:@"last-pond-finished"];
}

+ (BOOL) didFinishGame {
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"did-finish-game"];
}

@end
