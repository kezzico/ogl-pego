//
//  Game.h
//  Pego
//
//  Created by Lee Irvine on 12/30/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Peggy.h"
#import "Surface.h"
#import "Egg.h"
#import "Pond.h"
#import "Water.h"
#import "Physics.h"
#import "Force.h"

@class Physics, DoodadManager;
@interface Game : NSObject

@property (strong, nonatomic) Pond *pond;
@property (strong, nonatomic) Physics *physics;
@property (strong, nonatomic) NSArray *surfacesUnderPeggy;
@property (strong, nonatomic) Surface *surfaceMostUnderPeggy;
@property (strong, nonatomic) Surface *lastSurfaceUnderPeggy;
@property (nonatomic, assign) vec3 walkPeggyTo;
@property (nonatomic, assign) vec3 walkPeggyFrom;
@property (nonatomic, assign) BOOL isPeggyWalking;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSMutableArray *grabbedEggs;
@property (nonatomic, strong) DoodadManager *doodadManager;

+ (Game *) shared;
- (Peggy *) peggy;
- (void) movePeggy:(vec3) origin;
- (void) meltIce:(Surface *) ice;
- (BOOL) areAllEggsCollected;
- (void) loadPond:(NSInteger) level;
- (void) loadNextPond;
- (void) reset;
- (void) update;
- (void) addObserver:(id) observer;
- (void) removeObserver:(id) observer;
@end
