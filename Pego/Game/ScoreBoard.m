//
//  ScoreBoard.m
//  Pego
//
//  Created by Lee Irvine on 8/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "NSArray-Extensions.h"
#import "ScoreBoard.h"
#import "Score.h"
#import "PondList.h"

@implementation ScoreBoard

- (void) resetScoreBoard {
  NSArray *scores = [self allEntitiesNamed:@"Score" sortWith:nil];
  for (Score *score in scores) {
    [self.context delete:score];
  }
  
  [self.context save:nil];
}

- (NSInteger) highestPondCompleted {
  NSInteger highest = -1;
  NSArray *scores = [self allEntitiesNamed:@"Score" sortWith:nil];
  
  for(Score *score in scores) {
    NSInteger number = [[PondList shared] levelForPondName:score.pondName];
    if(number > highest) {
      highest = number;
    }
  }

  return highest;
}

- (void) saveScore:(float) time forPond:(NSString *) pondName {
  Score *score = (Score *)[self createEntityWithName:@"Score"];
  
  score.pondName = pondName;
  score.timeToFinish = [NSNumber numberWithFloat: time];
  
  [self.context save:nil];
}

- (NSNumber *) bestScoreForPond:(NSString *) pondName {
  NSPredicate *predicate = [NSPredicate predicateWithFormat: @"(pondName = %@", pondName];
  NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timeToFinish" ascending:YES];
  
  NSArray *scores = [self entitiesNamed:@"Score" matching:predicate sortWith:sort];
  
  Score *bestTime = [scores firstObject];
  return bestTime.timeToFinish;
}

@end
