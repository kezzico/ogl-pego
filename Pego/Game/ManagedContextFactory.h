//
//  SharedContext.h
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ManagedContextFactory : NSObject
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *storeCoordinator;
@property (nonatomic, retain) NSURL *userStoreUrl;

+ (NSManagedObjectContext *) buildContext;
- (NSManagedObjectContext *) buildContext;
- (void) setup;

@end