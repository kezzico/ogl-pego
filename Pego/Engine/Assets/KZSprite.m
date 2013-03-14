//
//  Sprite.h
//  Cheapo
//
//  Created by Lee Irvine on 11/7/11.
//  Copyright (c) 2013 Fareportal. All rights reserved.
//

#import "KZSprite.h"
#import "NSDictionary-Extensions.h"
#import "KZAnimation.h"
#import "KZShader.h"

@interface CachedSprite : NSObject
@property (nonatomic, strong) KZTexture *texture;
@property (nonatomic, strong) NSDictionary *animations;
@property (nonatomic) NSInteger cellWidth, cellHeight;
@end

@implementation CachedSprite
- (void) readFromSpriteData:(NSDictionary *) spritedata {
  self.texture = [KZTexture textureWithName: [spritedata valueForKey:@"texture"]];
  self.cellWidth = [[spritedata valueForKey:@"cell-width"] integerValue];
  self.cellHeight = [[spritedata valueForKey:@"cell-height"] integerValue];
  self.animations = [self readAnimations: [spritedata valueForKey:@"animations"]];
}

- (NSDictionary *) readAnimations:(NSDictionary *) a {
  NSMutableDictionary *output = [NSMutableDictionary dictionary];
  for(NSString *name in a) {
    NSArray *n = [a valueForKey: name];
    NSInteger start = [n[0] integerValue];
    NSInteger end = [n[1] integerValue];
    
    NSRange range = NSMakeRange(start, end - start);
    NSValue *rangeValue = [NSValue valueWithRange:range];
    [output setValue:rangeValue forKey:name];
  }
  
  return [NSDictionary dictionaryWithDictionary: output];
}

@end

@interface KZSprite () 
@property (nonatomic) NSInteger cellWidth, cellHeight;
@end

@implementation KZSprite

+ (KZSprite *) spriteWithName:(NSString *) name {
  NSMutableDictionary *cache = [NSDictionary cacheWithName:@"sprites"];
  CachedSprite *sprite = [cache valueForKey:name];
  
  if(sprite == nil) {
    NSDictionary *spritedata = [NSDictionary jsonFromResource:name ofType:@"sprite"];
    sprite = [[CachedSprite alloc] init];
    [sprite readFromSpriteData: spritedata];
    [cache setValue:sprite forKey:name];
  }

  KZSprite *s = [[KZSprite alloc] init];
  s.animation = [[KZAnimation alloc] initWithAnimations: sprite.animations];
  s.shader = [KZShader defaultShader];
  s.texture = sprite.texture;
  s.cellWidth = sprite.cellWidth;
  s.cellHeight = sprite.cellHeight;
  s.scale = 1.f;
  s.tint = _c(1, 1, 1, 1);

  return s;
}

+ (KZSprite *) spriteWithTexture:(KZTexture *) texture {
  KZSprite *s = [[KZSprite alloc] init];
  s.scale = 1.f;
  s.tint = _c(1, 1, 1, 1);
  s.texture = texture;
  
  return s;
}

- (NSUInteger) numVerts {
  return 4;
}

- (void) tverts:(GLfloat *) buffer {
  GLfloat box[] = { 0, 0, 1, 0, 0, 1, 1, 1 };
  
  if(self.texture.info != nil) {
    GLfloat scale = self.texture.scale;
    GLfloat xstep = 1.f / self.texture.info.width * _cellWidth * scale;
    GLfloat ystep = 1.f / self.texture.info.height * _cellHeight * scale;
    NSInteger hcells = self.texture.info.width / _cellWidth * scale;
    NSInteger vcells = self.texture.info.height / _cellHeight * scale;
    NSInteger x = _animation.frame % hcells, y = (vcells - 1) - (_animation.frame / hcells);
    
    for(int i=0;i<8;i+=2) {
      box[i] = box[i] * xstep + xstep * x;
      box[i+1] = box[i+1] * ystep + ystep * y;
    }
  }
  
  memcpy(buffer, box, sizeof(box));
}

- (void) verts: (GLfloat *) buffer {
  GLfloat halfwidth = _cellWidth * _scale * .5f;
  GLfloat halfheight = _cellHeight * _scale * .5f;
  vec3 *box = (vec3 *)buffer;
  
  box[0] = _v(-halfwidth, halfheight, 0);
  box[1] = _v( halfwidth, halfheight, 0);
  box[2] = _v(-halfwidth,-halfheight, 0);
  box[3] = _v( halfwidth,-halfheight, 0);
}

- (void) normals: (GLfloat *) buffer { }

@end

