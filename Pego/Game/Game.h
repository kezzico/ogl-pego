//
//  Game.h
//  Pego
//
//  Created by Lee Irvine on 12/30/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KezziEngine.h"
#import "Peggy.h"
#import "Ice.h"
#import "Egg.h"
#import "Pond.h"
#import "Water.h"
#import "Physics.h"
#import "Force.h"

@class Physics, DoodadManager;
@interface Game : NSObject
@property (strong, nonatomic) Pond *pond;
@property (strong, nonatomic) Physics *physics;
@property (strong, nonatomic) NSArray *iceUnderPeggy;
@property (strong, nonatomic) Ice *iceMostUnderPeggy;
@property (nonatomic, assign) vec3 walkPeggyTo;
@property (nonatomic, assign) vec3 walkPeggyFrom;
@property (nonatomic, assign) BOOL isPeggyWalking;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSMutableArray *grabbedEggs;
@property (nonatomic, strong) DoodadManager *doodadManager;
+ (Game *) shared;
- (Peggy *) peggy;
- (void) meltIce:(Ice *) ice;
- (BOOL) areAllEggsCollected;
- (void) loadPond:(NSInteger) level;
- (void) loadNextPond;
- (void) reset;
- (void) update;
@end
