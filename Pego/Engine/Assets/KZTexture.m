//
//  Texture.m
//  Penguin Cross
//
//  Created by Lee Irvine on 12/25/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZTexture.h"
#import "KZStage.h"
#import "NSArray-Extensions.h"
#import "NSDictionary-Extensions.h"

@implementation KZTexture

+ (KZTexture *) textureWithName:(NSString *) name {
  NSMutableDictionary *cache = [NSDictionary cacheWithName:@"textures"];
  KZTexture *t = [cache valueForKey:name];

  if(t == nil) {
    GLfloat scale;
    NSString *path = [KZTexture pathForImage: name scale: &scale];
    NSDictionary *options = @{GLKTextureLoaderOriginBottomLeft : @YES};
    t = [[KZTexture alloc] init];
    [cache setValue:t forKey:name];
    
    EAGLSharegroup *sharegroup = [[[KZStage stage] context] sharegroup];
    GLKTextureLoader *loader = [[GLKTextureLoader alloc] initWithSharegroup:sharegroup];
    [loader textureWithContentsOfFile:path options:options queue:nil completionHandler:^(GLKTextureInfo *info, NSError *error) {
      t.scale = scale;
      t.info = info;
    }];
  }
  
  return t;
}

+ (NSString *) pathForImage:(NSString *) name scale:(GLfloat *) scale {
  NSString *path = nil;
  if([[UIScreen mainScreen] scale] == 2.0) {
    NSString *hires = [@[name, @"@2x"] join];
    path = [[NSBundle mainBundle] pathForResource:hires ofType:@"png"];
    *scale = 2.f;
  }
  
  if(path == nil) {
    path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    *scale = 1.f;
  }
  
  return path;
}

- (GLuint) textureId {
  return _info.name;
}

@end
