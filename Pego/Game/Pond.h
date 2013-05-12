//
//  Pond.h
//  Pego
//
//  Created by Lee Irvine on 12/29/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Peggy, Water, Ice, PhysicalEntity;
@interface Pond : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Peggy *peggy;
@property (nonatomic, strong) Water *water;
@property (nonatomic, strong) NSArray *ices;
@property (nonatomic, strong) NSArray *eggs;
@property (nonatomic, strong) NSArray *iceInitialPositions;
@property (nonatomic, strong) NSArray *eggInitialPositions;
@property (nonatomic) vec3 peggyInitialPosition;
+ (Pond *) pondWithName:(NSString *) name;
- (NSArray *) iceUnderEntity:(PhysicalEntity *) entity;
- (Ice *) iceMostUnderEntity:(PhysicalEntity *) entity;
- (void) reset;
@end
