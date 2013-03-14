//
//  Bank.h
//  seatselector
//
//  Created by Lee Irvine on 10/18/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bank : NSObject {
  Class _type;
}
@property (nonatomic, retain) NSMutableArray *deposits;
- (id) withdraw;
- (id) initWithType:(Class) type;
- (void) deposit:(id) object;
- (void) depositMany:(NSArray *) objects;
+ (Bank *) bankWithType:(Class) type;
@end