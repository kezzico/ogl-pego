//
//  SimplePersistence.h
//  Pego
//
//  Created by Lee Irvine on 8/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimplePersistence : NSObject
+ (NSInteger) lastPondFinished;
+ (void) setLastPondFinished:(NSInteger) lastPond;
+ (BOOL) didFinishGame;
@end
