//
//  SurfaceEntity.h
//  Pego
//
//  Created by Lee Irvine on 6/3/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "PhysicalEntity.h"

@interface Surface : PhysicalEntity
@property (nonatomic, strong) KZTriangle *triangle;
@property (nonatomic, strong) KZTriangle *shadow;
@property (nonatomic) rgba color;
@property (nonatomic) BOOL canMelt;
@property (nonatomic) BOOL didMelt;
@property (nonatomic) BOOL isSurfable;
@property (nonatomic) float opacity;
+ (Surface *) spawnRockWithTriangle:(tri) t;
+ (Surface *) spawnIceWithTriangle:(tri) t;
@end
