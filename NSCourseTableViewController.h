//
//  NSCourseTableViewController.h
//  CoreData UNKNOWN
//
//  Created by Nik on 01.10.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCoreData.h"

@protocol sendCourse

- (void) courseShow:(NSString*)course;

@end

@interface NSCourseTableViewController : UITableViewController <NSFetchedResultsControllerDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationBarDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) id <sendCourse> delegate;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;



@end
