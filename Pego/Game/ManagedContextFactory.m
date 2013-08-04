//
//  ManagedContextFactory.m
//  RecipeKing
//
//  Created by Lee Irvine on 2/17/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "ManagedContextFactory.h"

static ManagedContextFactory *sharedContextFactory;
@implementation ManagedContextFactory

+ (void) initialize {
  sharedContextFactory = [[ManagedContextFactory alloc] init];
  NSURL *libraryDir = [[[NSFileManager defaultManager] URLsForDirectory: NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
  sharedContextFactory.userStoreUrl = [libraryDir URLByAppendingPathComponent: @"CheapOairUser.sqlite"];
  [sharedContextFactory setup];
}

+ (NSManagedObjectContext *) buildContext {
  return [sharedContextFactory buildContext];
}

- (void) setup {
  [self setupObjectModel];
  [self setupStoreCoordinator];
}

- (void) setupObjectModel {
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CheapoAir" withExtension:@"momd"];
  self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
}

- (void) setupStoreCoordinator {
  NSError *staticError = nil, *userError = nil;
  NSDictionary *userOptions = @{NSMigratePersistentStoresAutomaticallyOption:@YES,NSInferMappingModelAutomaticallyOption:@YES};
  self.storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: self.managedObjectModel];
  NSDictionary *staticOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:1] forKey:NSReadOnlyPersistentStoreOption];
  
  [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"StaticData" URL: self.staticStoreUrl options:staticOptions error:&staticError];
  [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"UserData" URL: self.userStoreUrl options:userOptions error:&userError];
  NSAssert(staticError == nil, @"static persistent store error: %d", staticError.code);
  
  if(userError) {
    NSLog(@"User persistent store is corrupted. Reseting...");
    [[NSFileManager defaultManager] removeItemAtURL: [self userStoreUrl] error: nil];
    [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"UserData" URL: self.userStoreUrl options:nil error:&userError];
    NSAssert(userError == nil, @"user persistent store error: %d", userError.code);
  }
}

- (NSURL *) staticStoreUrl {
  NSString *output = [[NSBundle mainBundle] pathForResource:@"CheapOairStatic" ofType:@"sqlite"];
  return [NSURL fileURLWithPath:output];
}

- (NSManagedObjectContext *) buildContext {
  NSManagedObjectContext *output = [[NSManagedObjectContext alloc] init];
  [output setPersistentStoreCoordinator:self.storeCoordinator];
  return output;
}

@end
