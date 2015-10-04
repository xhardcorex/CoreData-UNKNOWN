//
//  NSGetAllStudentsTVC.m
//  CoreData UNKNOWN
//
//  Created by Nik on 04.10.15.
//  Copyright © 2015 Nik. All rights reserved.
//

#import "NSGetAllStudentsTVC.h"


@interface NSGetAllStudentsTVC ()

@end

@implementation NSGetAllStudentsTVC
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize fetchedResultsController2 = _fetchedResultsController2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fetchedResultsController = [[NSCoreData sharedManager] getAllStudents];
    self.fetchedResultsController.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [[self.fetchedResultsController fetchedObjects] count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.fetchedResultsController2 = [[NSCoreData sharedManager] getStudentsFromCourse:@"IOS"];
    
    NSCourse* course = [[self.fetchedResultsController2 fetchedObjects] objectAtIndex:0];
    NSStudent* student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
      
        [course removeStudentsObject:student];
    }
    else{
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [course addStudentsObject:student];
    }
    
    
    NSPrintCourseStudentsTableViewController* tvc =[[self.navigationController viewControllers] objectAtIndex:1];
    [tvc.tableView reloadData];
}
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (NSFetchedResultsController *)fetchedResultsController2
{
    if (_fetchedResultsController2 != nil) {
        return _fetchedResultsController2;
    }
    
    
    NSError *error = nil;
    if (![self.fetchedResultsController2 performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController2;
}

- (NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSCoreData sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier =@"Identifier";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //Если ячейка не найдена
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:  UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    NSStudent* student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@ %@ ",student.lastName ,student.firstName];
    
    NSArray* arrayOfThisCourse = [[NSCoreData sharedManager] getStudentsFromIosCourse];
    NSLog(@"OBJECTS = %d",[arrayOfThisCourse count]);
    

    if ([arrayOfThisCourse containsObject:student]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
