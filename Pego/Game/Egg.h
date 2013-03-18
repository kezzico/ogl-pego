//
//  Egg.h
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZEntity.h"

@interface Egg : KZEntity
@property (nonatomic, strong) KZSprite *sprite;
+ (Egg *) spawn: (vec3) origin;

@end
