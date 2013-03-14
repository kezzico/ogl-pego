//
//  NSObject+NSString_Extensions.m
//  CheapoAir
//
//  Created by MAC9 on 11/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString-Extensions.h"

@implementation NSString (Extensions)

- (BOOL) containsString: (NSString *) str {
  NSRange range = [self rangeOfString: str];
  return range.location != NSNotFound;
}

+ (BOOL) isEmpty: (NSString *) str {
  return [[str trim] length] == 0;
}

- (NSString *) search:(NSString *)regex replace:(NSString *)s {
  NSRegularExpression *r = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:nil];
  NSString *output = [r stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
  return output;
}

- (BOOL) isMatch:(NSString *) regex {
  NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", regex];
  return [test evaluateWithObject: self];  
}

- (NSString *) trim {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (BOOL) isEmailAddress {
  return [self isMatch:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

- (NSString *) htmlEncode {
  NSString *output = [self search:@"\\&" replace:@"&amp"];
  output = [output search:@"<" replace:@"&lt;"];
  output = [output search:@">" replace:@"&gt;"];
  output = [output search:@"'" replace:@"&apos;"];
  output = [output search:@"\"" replace:@"&quot;"];
  return output;
}

@end