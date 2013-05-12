//
//  Fish.m
//  Pego
//
//  Created by Lee Irvine on 5/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Doodads.h"

@implementation Doodad
+ (Doodad *) spawnBigWhale {
  Doodad *whale = [Doodad doodadWithImage:@"fish_big" size:_v2(598, 227) underWater:YES];
  whale.speed = 0.6f;
  whale.name = @"bigwhale";
  
  return whale;
}

+ (Doodad *) spawnWhale {
  Doodad *whale = [Doodad doodadWithImage:@"fish_medium" size:_v2(84, 42) underWater:YES];
  whale.speed = (arc4random() % 40 + 6) / -9.f;
  whale.name = @"whale";
  
  return whale;
}

+ (Doodad *) spawnFishSchool {
  Doodad *school = [Doodad doodadWithImage:@"fishschool" size:_v2(121, 55) underWater:YES];
  school.speed = (arc4random() % 50 + 10) / 9.f;
  school.name = @"school";
  
  return school;

}

+ (Doodad *) spawnCloud {
  NSString *image = arc4random() % 2 == 0 ? @"cloud1" : @"cloud2";
  Doodad *cloud = [Doodad doodadWithImage:image size:_v2(210, 140) underWater:NO];
  cloud.speed = 1.2f;
  cloud.name = @"cloud";
  
  return cloud;
}

+ (Doodad *) spawnBabyCloud {
  Doodad *cloud = [Doodad doodadWithImage:@"cloud3" size:_v2(105, 80) underWater:NO];
  cloud.speed = 1.2f;
  cloud.name = @"babycloud";
  
  return cloud;
}

+ (Doodad *) doodadWithImage:(NSString *) image size:(vec2) size underWater:(BOOL) isUnderWater {
  GLfloat halfwidth = size.x * .5f, halfheight = size.y * .5f;
  Doodad *doodad = [[Doodad alloc] init];
  KZRectangle *asset = [KZRectangle rectangle:
    _r(_v(-halfwidth, -halfheight, 0), _v(halfwidth, halfheight, 0))];
  asset.texture = [KZTexture textureWithName:image];
  if(isUnderWater) {
    asset.zIndex = 1;
  } else {
    asset.zIndex = 16;
    doodad.renderPriority = 2;
  }

  doodad.assets = @[asset];
  doodad.width = asset.width;
  doodad.height = asset.height;

  return doodad;
}

@end
