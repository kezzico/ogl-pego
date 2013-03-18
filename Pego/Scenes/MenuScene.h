//
//  MenuScene.h
//  Pego
//
//  Created by Lee Irvine on 3/10/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "KZScene.h"
@class KZEntity, KZSprite;
@interface MenuScene : KZScene
@property (nonatomic, strong) KZEntity *pego;
@property (nonatomic, strong) KZSprite *sprite;
@property (nonatomic, strong) KZTriangle *triangle;
@property (nonatomic) BOOL isIdle;
@end
