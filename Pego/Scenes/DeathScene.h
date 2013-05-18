//
//  PauseScene.h
//  Penguin Cross
//
//  Created by Lee Irvine on 12/31/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

@class Game;
@interface DeathScene : KZScene
@property (nonatomic, strong) KZView *background;
@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) KZView *loserView;
@property (nonatomic, strong) KZView *tryagainButton;
@property (nonatomic, assign) SEL onupdate;
@end
