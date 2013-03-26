//
//  Animation.h
//  PenguinCross
//
//  Created by Lee Irvine on 8/12/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZAnimation : NSObject
@property (nonatomic, readonly) NSUInteger frame;
@property (nonatomic) BOOL isLooping;
- (id) initWithAnimations:(NSDictionary *) animations;
- (void) setNextAnimationLoop:(NSString *) loopname looping:(BOOL) isLooping;
- (void) setAnimationLoop:(NSString *) loopname;
- (NSString *) currentAnimation;
- (void) nextFrame;
@end
