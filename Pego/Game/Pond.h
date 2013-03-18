//
//  Pond.h
//  Penguin Cross
//
//  Created by Lee Irvine on 12/29/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pond : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) KZEntity *peggy;
@property (nonatomic, strong) NSArray *ices;
@property (nonatomic, strong) NSArray *eggs;
@property (nonatomic, strong) NSArray *iceInitialPositions;
@property (nonatomic, strong) NSArray *eggInitialPositions;
@property (nonatomic) vec3 peggyInitialPosition;
+ (Pond *) pondWithName:(NSString *) name;
- (KZEntity *) findIceUnderPeggy;
- (void) reset;
@end
