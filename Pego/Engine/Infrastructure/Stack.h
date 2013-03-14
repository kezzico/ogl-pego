//
//  Stack.h
//  CheapoAir
//
//  Created by Lee Irvine on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
- (NSInteger) count;
- (void) push: (id) object;
- (void) empty;
- (id) pop;
- (id) peek;
- (id) popToFirst;

@end
