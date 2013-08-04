//
//  Repository.m
//  CheapoAir
//
//  Created by Lee Irvine on 8/8/12.
//  Copyright (c) 2012 Fareportal. All rights reserved.
//

#import "Repository.h"
#import "NSArray-Extensions.h"
#import "ManagedContextFactory.h"

@implementation Repository

- (id) init {
  if(self = [super init]) {
    self.context = [ManagedContextFactory buildContext];
  }
  return self;
}

- (NSManagedObject *) firstEntityNamed:(NSString *) entityName withAttribute:(NSString *) attribute equalTo:(NSObject *) value {
  NSEntityDescription *entityDescription = [NSEntityDescription entityForName: entityName inManagedObjectContext: self.context];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDescription];
  NSPredicate *predicate = [NSPredicate predicateWithFormat: @"%K = %@", attribute, value];
  [request setPredicate:predicate];
  
  NSError *error = nil;
  NSArray *output = [_context executeFetchRequest: request error: &error];
  if(error) {
    NSLog(@"failed retrieving entity named: %@ with code: %d", entityName, error.code);
  }
  
  return [output firstObject];
}

- (NSArray *) allEntitiesNamed:(NSString *) entityName sortWith:(NSSortDescriptor *) sortDescriptor {
  NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext: self.context];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDescription];
  
  if(sortDescriptor) {
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
  }
  
  NSError *error = nil;
  NSArray *output = [_context executeFetchRequest: request error: &error];
  if(error) {
    NSLog(@"%@", error);
    return nil;
  }
  
  return output;
}

- (NSArray *) entitiesNamed:(NSString *)entityName matching:(NSPredicate *) predicate sortWith:(NSSortDescriptor *)sortDescriptor {
  NSEntityDescription *entityDescription = [NSEntityDescription entityForName: entityName inManagedObjectContext: self.context];
  
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDescription];
  [request setPredicate:predicate];
  if(sortDescriptor) {
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
  }
  
  NSError *error = nil;
  NSArray *output = [self.context executeFetchRequest:request error:&error];
  
  if(error) {
    NSLog(@"failed retrieving entities named: %@ with predicate: %@", entityName, predicate);
  }
  
  return output;
}

- (NSManagedObject *) createEntityWithName:(NSString *) name {
  return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext: self.context];
}

@end
