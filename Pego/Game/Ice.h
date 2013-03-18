//
//  Ice.h
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZEntity.h"

@interface Ice : KZEntity
@property (nonatomic, strong) KZTriangle *triangle;
+ (Ice *) spawn:(vec3) origin withTriangle:(KZTriangle *) triangle;
@end
