//
//  NSDictionary-Extensions.m
//  Cheapo
//
//  Created by Lee Irvine on 3/1/13.
//  Copyright (c) 2013 fareportal. All rights reserved.
//

#import "NSDictionary-Extensions.h"

@implementation NSDictionary (Extensions)
+ (NSDictionary *) jsonFromResource:(NSString *) resource ofType:(NSString *) type {
  NSString *path = [[NSBundle mainBundle] pathForResource: resource ofType: type];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSError *error = nil;
  
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  if(error) {
    NSLog(@"%@", error);
    return nil;
  }
  
  return json;
}

+ (NSMutableDictionary *) cacheWithName:(NSString *) name {
  static NSMutableDictionary *caches = nil;
  if(caches == nil) {
    caches = [NSMutableDictionary dictionary];
  }
  
  NSMutableDictionary *cache = [caches valueForKey:name];
  if(cache == nil) {
    cache = [NSMutableDictionary dictionary];
    [caches setValue:cache forKey:name];
  }

  return cache;
}

@end
