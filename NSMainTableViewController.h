//
//  NSMainTableViewController.h
//  CoreData UNKNOWN
//
//  Created by Nik on 30.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCoreData.h"

@interface NSMainTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end
