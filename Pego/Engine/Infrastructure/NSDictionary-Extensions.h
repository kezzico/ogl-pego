//
//  NSDictionary-Extensions.h
//  Cheapo
//
//  Created by Lee Irvine on 3/1/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extensions)
+ (NSDictionary *) jsonFromResource:(NSString *) resource ofType:(NSString *) type;
+ (NSMutableDictionary *) cacheWithName:(NSString *) name;
@end
