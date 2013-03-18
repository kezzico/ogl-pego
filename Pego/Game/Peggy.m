//
//  Peggy.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Peggy.h"

@implementation Peggy
+ (Peggy *) spawn: (vec3) origin {
  Peggy *peggy = [[Peggy alloc] init];
  peggy.sprite = [KZSprite spriteWithName:@"peggy"];
  peggy.assets = @[peggy.sprite];
  peggy.origin = origin;
  
  return peggy;

}
@end
