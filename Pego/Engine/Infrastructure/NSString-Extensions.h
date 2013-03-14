//
//  NSObject+NSString_Extensions.h
//  CheapoAir
//
//  Created by MAC9 on 11/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

- (NSString *) search:(NSString *) regex replace:(NSString *) s;
- (BOOL) containsString: (NSString *) str;
- (BOOL) isMatch:(NSString *) regex;
+ (BOOL) isEmpty: (NSString *) str;
- (NSString *) htmlEncode;
- (BOOL) isEmailAddress;
- (NSString *) trim;
@end