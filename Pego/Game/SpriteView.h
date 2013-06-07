//
//  SpriteView.h
//  Pego
//
//  Created by Lee Irvine on 5/22/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpriteView : KZView
@property (nonatomic, strong) KZSprite *sprite;

+ (SpriteView *) viewWithSprite:(NSString *) name position:(float)x : (float) y;

@end
