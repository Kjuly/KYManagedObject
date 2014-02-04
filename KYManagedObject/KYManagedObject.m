//
//  KYManagedObject.m
//  KYManagedObject
//
//  Created by Kjuly on 2/2/14.
//  Copyright (c) 2014 Kjuly. All rights reserved.
//

#import "KYManagedObject.h"

@implementation KYManagedObject

// Save
+ (BOOL)saveWithManagedObjectContext:(NSManagedObjectContext *)moc
{
  NSError * error = nil;
  if (! [moc save:&error]) {
    NSLog(@"!!! Couldn't save data to %@", NSStringFromClass([self class]));
    return NO;
  }
  return YES;
}

#pragma mark - GET

// All
+ (NSArray *)allWithManagedObjectContext:(NSManagedObjectContext *)moc
{
  NSFetchRequest * fetchRequest = [self fetchRequestWithManagedObjectContext:moc];
  NSError * error = nil;
  NSArray * fetchedObjects = [moc executeFetchRequest:fetchRequest
                                                error:&error];
  return fetchedObjects;
}

// Get all items count
+ (NSInteger)countForAllItemsWithManagedObjectContext:(NSManagedObjectContext *)moc
{
  NSError * error = nil;
  NSInteger count = [moc countForFetchRequest:[self fetchRequestWithManagedObjectContext:moc]
                                        error:&error];
  if (error) {
    NSLog(@"!!! Count All Items Error: %@", error);
    return 0;
  }
  
  return count;
}

+ (NSNumber *)uidForNewItemWithManagedObjectContext:(NSManagedObjectContext *)moc
{
  NSInteger count = [self countForAllItemsWithManagedObjectContext:moc];
  return @(count); // start from 1
  //return @(++count);
}

+ (id)        itemForUID:(NSNumber *)uid
withManagedObjectContext:(NSManagedObjectContext *)moc
{
  NSFetchRequest * fetchRequest = [self fetchRequestWithManagedObjectContext:moc];
  [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"uid == %@", uid]];
  [fetchRequest setFetchLimit:1];
  
  NSError * error = nil;
  NSArray * fetchedObjects = [moc executeFetchRequest:fetchRequest
                                                error:&error];
  return [fetchedObjects lastObject];
}

#pragma mark - SET

+ (void)addItemWithManagedObjectContext:(NSManagedObjectContext *)moc {}

+ (void)addItem:(NSDictionary *)item withManagedObjectContext:(NSManagedObjectContext *)moc {}

+ (void)updateItem:(id)item withManagedObjectContext:(NSManagedObjectContext *)moc {}

#pragma mark - DELETE

// Clean All
+ (void)cleanAllWithManagedObjectContext:(NSManagedObjectContext *)moc
{
  NSError * error = nil;
  NSArray * fetchedObjects = [moc executeFetchRequest:[self fetchRequestWithManagedObjectContext:moc]
                                                error:&error];
  
  // delete objects
  for (NSManagedObject *managedObject in fetchedObjects)
    [moc deleteObject:managedObject];
  
  // save
  (void)[self saveWithManagedObjectContext:moc];
}

// Delete Item
+ (void)      deleteItem:(id)item
withManagedObjectContext:(NSManagedObjectContext *)moc
{
  [moc deleteObject:item];
  (void)[self saveWithManagedObjectContext:moc];
}

#pragma mark - HELPER

// Generate New Entity
+ (id)generateEntityWithManagedObjectContext:(NSManagedObjectContext *)moc
{
  return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class])
                                       inManagedObjectContext:moc];
}

// Basic fetch request
+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)moc
{
  NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
  [fetchRequest setEntity:[NSEntityDescription entityForName:NSStringFromClass([self class])
                                      inManagedObjectContext:moc]];
  return fetchRequest;
}

@end

