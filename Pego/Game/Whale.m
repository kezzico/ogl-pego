//
//  Fish.m
//  Pego
//
//  Created by Lee Irvine on 5/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Whale.h"

@implementation Whale
+ (Whale *) spawn {
  KZRectangle *asset = nil;
  Whale *whale = [[Whale alloc] init];
  whale.bigWhale = arc4random() % 10 > 7;

  
  if(whale.bigWhale) {
    asset = [KZRectangle rectangle:_r(_v(-299, -113.5, 0), _v(299, 113.5, 0))];
    asset.texture = [KZTexture textureWithName:@"fish_big"];
    whale.origin = _v(-asset.width, arc4random() % 768, 0);
  } else {
    asset = [KZRectangle rectangle:_r(_v(-42, -21, 0), _v(42, 21, 0))];
    asset.texture = [KZTexture textureWithName:@"fish_medium"];
    whale.origin = _v(asset.width + 1024.f, arc4random() % 768, 0);
  }

  asset.zIndex = 1;
  whale.assets = @[asset];
  whale.speed = (arc4random() % 10 + 1) / .08f * (whale.bigWhale ? 1.f : -1.f);
  
  return whale;
}

- (float) width {
  KZRectangle *rect = self.assets[0];
  return [rect width];
}

@end
