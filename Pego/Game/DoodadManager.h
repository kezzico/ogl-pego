//
//  DoodadManager.h
//  Pego
//
//  Created by Lee Irvine on 5/7/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoodadManager : NSObject
@property (nonatomic, strong) NSMutableArray *doodads;
@property (nonatomic, strong) KZEvent *repopulateEvent;
@property (nonatomic, assign) NSInteger eventTick;
- (void) reset;
- (void) update;

@end
