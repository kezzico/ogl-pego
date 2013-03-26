//
//  Collision.m
//  PenguinCross
//
//  Created by Lee Irvine on 10/6/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Collision.h"

@implementation Collision
- (NSString *) description {
  return [NSString stringWithFormat:@"%@ collided with %@ with", _attacker, _victim];
}
@end
