//
//  DataBaseHelper.h
//  WordLearning
//
//  Created by Khvorostov on 09/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DataBaseInitiator : NSObject

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+(DataBaseInitiator *) instance;
-(NSApplicationTerminateReply) saveChangesBeforeExit:(NSApplication *)sender;
-(NSManagedObjectContext *) managedObjectContext;
@end
