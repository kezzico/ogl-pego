//
//  Repository.h
//  CheapoAir
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 Fareportal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Repository : NSObject
@property (nonatomic, retain) NSManagedObjectContext *context;
- (NSManagedObject *) firstEntityNamed:(NSString *) entityName withAttribute:(NSString *) attribute equalTo:(NSObject *) value;
- (NSArray *) allEntitiesNamed:(NSString *) entityName sortWith:(NSSortDescriptor *) sortDescriptor;
- (NSArray *) entitiesNamed:(NSString *)entityName matching:(NSPredicate *) predicate sortWith:(NSSortDescriptor *)sortDescriptor;
- (NSManagedObject *) createEntityWithName:(NSString *) name;
@end
