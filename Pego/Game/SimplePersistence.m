//
//  SimplePersistence.m
//  Pego
//
//  Created by Lee Irvine on 8/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "SimplePersistence.h"

@implementation SimplePersistence

+ (NSInteger) lastPondFinished {
  return [[NSUserDefaults standardUserDefaults] integerForKey:@"last-pond-finished"];
}

+ (void) setLastPondFinished:(NSInteger) lastPond {
  [[NSUserDefaults standardUserDefaults] setInteger:lastPond forKey:@"last-pond-finished"];
}

@end
