//
//  Ice.h
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "PhysicalEntity.h"

@interface Ice : PhysicalEntity
@property (nonatomic, strong) KZTriangle *triangle;
@property (nonatomic, strong) KZTriangle *shadow;
@property (nonatomic) BOOL canMelt;
@property (nonatomic) BOOL didMelt;
@property (nonatomic) float blue;
@property (nonatomic) float opacity;

+ (Ice *) spawn:(vec3) origin withTriangle:(KZTriangle *) triangle;
@end
