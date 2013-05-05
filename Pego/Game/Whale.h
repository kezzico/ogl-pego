//
//  Fish.h
//  Pego
//
//  Created by Lee Irvine on 5/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZEntity.h"
#import "Doodad.h"

@interface Whale : KZEntity <Doodad>
@property (nonatomic) BOOL bigWhale;
@property (nonatomic) float speed;

+ (Whale *) spawn;
@end
