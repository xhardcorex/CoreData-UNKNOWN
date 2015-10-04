//
//  NSPrintCourseStudentsTableViewController.h
//  CoreData UNKNOWN
//
//  Created by Nik on 02.10.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCourseTableViewController.h"
#import "NSMainTableViewController.h"
#import "NSGetAllStudentsTVC.h"


@interface NSPrintCourseStudentsTableViewController : UITableViewController <sendCourse,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) id <sendStudentDelegate> delegate;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
