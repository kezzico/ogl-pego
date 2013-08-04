//
//  GameScene.h
//  Pego
//
//  Created by Lee Irvine on 3/13/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game, ScoreBoard;
@interface GameScene : KZScene
@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) KZView *pauseButton;
@property (nonatomic, strong) KZView *restartButton;
@property (nonatomic, strong) KZView *black;
@property (nonatomic, strong) NSArray *hudEggs;
@property (strong, nonatomic) ScoreBoard *scoreboard;
@end
