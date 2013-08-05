//
//  PondList.h
//  Pego
//
//  Created by Lee Irvine on 2/5/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PondList : NSObject
@property (nonatomic, retain) NSArray *allPondNames;
+ (PondList *) shared;
- (NSString *) pondNameForLevel:(NSInteger) level;
- (NSInteger) levelForPondName:(NSString *) name;
- (NSInteger) numberOfLevels;
@end
