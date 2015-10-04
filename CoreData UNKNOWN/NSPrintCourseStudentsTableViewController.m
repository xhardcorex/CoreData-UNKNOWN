//
//  NSPrintCourseStudentsTableViewController.m
//  CoreData UNKNOWN
//
//  Created by Nik on 02.10.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "NSPrintCourseStudentsTableViewController.h"
#import "NSCourse.h"
#import "NSCreateStudentTableViewController.h"




@interface NSPrintCourseStudentsTableViewController ()
@property (strong,nonatomic) NSArray* arrayOfStudents;
@property (strong,nonatomic) NSString* nameCourse;
@property (strong,nonatomic) NSCourse* course;
@end

@implementation NSPrintCourseStudentsTableViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsController = _fetchedResultsController;

- (void) courseShow:(NSString *)course{
    NSLog(@"DELEGATE");
    self.nameCourse = course;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Name course = %@",self.nameCourse);
    self.fetchedResultsController = [[NSCoreData sharedManager] getStudentsFromCourse:self.nameCourse];
    
 
   NSArray* array   = [self.fetchedResultsController fetchedObjects];
   self.course = [array objectAtIndex:0];
    
    self.arrayOfStudents = [self.course.students allObjects];
    NSLog(@"Count = %lu",(unsigned long)[self.arrayOfStudents count]);
    
    //self.fetchedResultsController =[[NSCoreData sharedManager] getAllStudents];
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Добавить студентов"
                                   style:UIBarButtonSystemItemAdd
                                   target:self
                                   action:@selector(getAllStudents:)];
    self.navigationItem.rightBarButtonItem = flipButton;
}
- (void) getAllStudents:(UIBarButtonItem*) sender{
    
    NSGetAllStudentsTVC* tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"NSGetAllStudentsTVC"];
    
    [self.navigationController pushViewController:tvc animated:YES];
    
    NSLog(@"WORK IT!");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.fetchedResultsController = [[NSCoreData sharedManager] getStudentsFromCourse:self.nameCourse];
   NSArray* array   = [self.fetchedResultsController fetchedObjects];
    self.course = [array objectAtIndex:0];
    
    self.arrayOfStudents = [self.course.students allObjects];
       return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return @"Описание курса";
            break;
            
        case 1:
            return @"Студенты";
            break;
            
        default:
            break;
    }
    
    
return @"UNKNOWN";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    switch (section) {
        case 0:
            return 3;
            break;
            
        case 1:
            return [self.arrayOfStudents count];
            break;
            
        default:
            break;
    }
    return 0;
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier =@"Identifier";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //Если ячейка не найдена
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:  UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
   // NSStudent* student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if (indexPath.section == 0 ) {
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = [NSString stringWithFormat:@"Название курса: %@",self.course.nameOfCourse];
                
                break;
            case 1:
                cell.textLabel.text = [NSString stringWithFormat:@"Преподаватель: %@",self.course.mentorName];
                
                break;
            case 2:
                cell.textLabel.text = [NSString stringWithFormat:@"Количество студентов: %d",[self.arrayOfStudents count]];
                
                break;
            default:
                break;
        }
        
    }else{
        
        NSStudent* student = [self.arrayOfStudents objectAtIndex:indexPath.row];
        cell.textLabel.text =[NSString stringWithFormat:@"%@ %@ ",student.firstName,student.lastName ];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        NSCreateStudentTableViewController* tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"NSCreateStudentTableViewController"];
        
        NSStudent* student = [self.arrayOfStudents objectAtIndex:indexPath.row];
        self.delegate = tvc;
        [_delegate sendStudent:student];
        
        //NSLog(@"%@ %@ %@",student.firstName,student.lastName,student.age);
        
        [self.navigationController pushViewController:tvc animated:YES];
       

        
    }
    
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
- (NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSCoreData sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mark - Core Data stack
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "nik.CoreData_UNKNOWN" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
