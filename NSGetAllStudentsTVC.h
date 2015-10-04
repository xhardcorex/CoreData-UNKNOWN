//
//  NSGetAllStudentsTVC.h
//  CoreData UNKNOWN
//
//  Created by Nik on 04.10.15.
//  Copyright © 2015 Nik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCoreData.h"
#import "NSPrintCourseStudentsTableViewController.h"

@interface NSGetAllStudentsTVC : UITableViewController <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController2;



@end
