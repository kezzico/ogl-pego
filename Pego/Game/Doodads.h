//
//  Fish.h
//  Pego
//
//  Created by Lee Irvine on 5/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZEntity.h"

@interface Doodad : KZEntity
@property (nonatomic) float speed;
@property (nonatomic) float width;
@property (nonatomic) float height;

+ (Doodad *) spawnBigWhale;
+ (Doodad *) spawnWhale;
+ (Doodad *) spawnFishSchool;
+ (Doodad *) spawnCloud;
+ (Doodad *) spawnBabyCloud;
@end
