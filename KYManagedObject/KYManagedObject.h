//
//  KYManagedObject.h
//  KYManagedObject
//
//  Created by Kjuly on 2/2/14.
//  Copyright (c) 2014 Kjuly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KYManagedObject : NSManagedObject

// Save
+ (BOOL)saveWithManagedObjectContext:(NSManagedObjectContext *)moc;

// GET
+ (NSArray *)allWithManagedObjectContext:(NSManagedObjectContext *)moc;
+ (NSInteger)countForAllItemsWithManagedObjectContext:(NSManagedObjectContext *)moc;
+ (NSNumber *)uidForNewItemWithManagedObjectContext:(NSManagedObjectContext *)moc;
+ (id)itemForUID:(NSNumber *)uid withManagedObjectContext:(NSManagedObjectContext *)moc;

// SET
+ (void)addItemWithManagedObjectContext:(NSManagedObjectContext *)moc;
+ (void)addItem:(NSDictionary *)item withManagedObjectContext:(NSManagedObjectContext *)moc;
+ (void)updateItem:(id)item withManagedObjectContext:(NSManagedObjectContext *)moc;

// DELETE
+ (void)cleanAllWithManagedObjectContext:(NSManagedObjectContext *)moc;
+ (void)      deleteItem:(id)item
withManagedObjectContext:(NSManagedObjectContext *)moc;

// HELPER
+ (id)generateEntityWithManagedObjectContext:(NSManagedObjectContext *)moc;
+ (NSFetchRequest *)fetchRequestWithManagedObjectContext:(NSManagedObjectContext *)moc;

@end
