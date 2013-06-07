//
//  VictoryScene.h
//  Penguin Cross
//
//  Created by Lee Irvine on 2/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

@class Game, SpriteView;
@interface VictoryScene : KZScene
@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) KZView *background;
@property (nonatomic, strong) SpriteView *peggyslap;
@end
