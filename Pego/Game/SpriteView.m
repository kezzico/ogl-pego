//
//  SpriteView.m
//  Pego
//
//  Created by Lee Irvine on 5/22/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "SpriteView.h"

@implementation SpriteView

+ (SpriteView *) viewWithSprite:(NSString *) name position:(float)x : (float) y {
  SpriteView *view = [[SpriteView alloc] init];
  view.tint = _c(1,1,1,1);
  view.sprite = [KZSprite spriteWithName:name];
  view.x = x;
  view.y = y;
  
  return view;
}

- (float) height {
  return self.sprite.texture.info.height;
}

- (float) width {
  return self.sprite.texture.info.width;
}

- (CGRect) rect {
  return CGRectMake(self.x, self.y, self.width, self.height);
}

- (void) tverts:(GLfloat *)buffer {
  [self.sprite tverts:buffer];
}

- (void) verts:(GLfloat *)buffer {
  [self.sprite verts: buffer];
}

- (KZTexture *) texture {
  return self.sprite.texture;
}


@end
