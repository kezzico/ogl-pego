//
//  Peggy.h
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "PhysicalEntity.h"
@interface Peggy : PhysicalEntity
@property (nonatomic, strong) KZSprite *sprite;
@property (nonatomic, strong) KZRectangle *shadow;
+ (Peggy *) spawn: (vec3) origin;
- (void) animateWalking;
- (void) animateIdling;
- (void) animateBlinking;
- (void) animateBreaking;
- (void) animateDeath;
- (void) animateSmile;
@end
