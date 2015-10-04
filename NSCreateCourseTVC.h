//
//  NSCreateCourseTVC.h
//  CoreData UNKNOWN
//
//  Created by Nik on 04.10.15.
//  Copyright © 2015 Nik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSCoreData.h"

@interface NSCreateCourseTVC : UITableViewController  <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameOfGroup;
@property (weak, nonatomic) IBOutlet UITextField *nameOfMentor;
- (IBAction)addGroup:(id)sender;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;



@end
