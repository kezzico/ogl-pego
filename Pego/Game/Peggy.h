//
//  Peggy.h
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZEntity.h"

@interface Peggy : KZEntity
@property (nonatomic, strong) KZSprite *sprite;
+ (Peggy *) spawn: (vec3) origin;
@end
