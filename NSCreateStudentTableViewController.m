//
//  NSCreateStudentTableViewController.m
//  CoreData UNKNOWN
//
//  Created by Nik on 30.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "NSCreateStudentTableViewController.h"
#import "NSStudent.h"
#import "NSMainTableViewController.h"

@interface NSCreateStudentTableViewController ()
@property (strong,nonatomic) NSStudent* student;
@end

@implementation NSCreateStudentTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


#pragma mark  - send student delegate

- (void) sendStudent:(NSStudent *)student{
    
    NSLog(@"DELEGATE");
    self.student = student;
   
}

#pragma mark  - create Methods

- (NSStudent*) addStudentFromController:(NSStudent*) student {
    
    student =
    [NSEntityDescription insertNewObjectForEntityForName:@"NSStudent"
                                  inManagedObjectContext:self.managedObjectContext];
    NSError* error = nil;
    
    if(![self.managedObjectContext save:&error]){
        
        NSLog(@"%@",[error localizedDescription]);
        
    }
    
    return student;
}

- (void) setTextFields{
    
    self.firstNameTextField.text = self.student.firstName;
    self.lastNameTextField.text = self.student.lastName;
    self.ageTextField.text = [NSString stringWithFormat:@"%@" ,self.student.age ? self.student.age :@" " ];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTextFields];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


- (IBAction)addNewStudent:(id)sender {
    
    NSStudent* student =
    [NSEntityDescription insertNewObjectForEntityForName:@"NSStudent"
                                  inManagedObjectContext:self.managedObjectContext];
    
    student.firstName = self.firstNameTextField.text;
    student.lastName = self.lastNameTextField.text;
    student.age = [NSNumber numberWithInteger:[self.ageTextField.text integerValue]];
    

    [self deleteAndInsert];
   
   /* NSStudent* student = [[NSStudent alloc]init];
    
    student.firstName = self.firstNameTextField.text;
    student.lastName = self.lastNameTextField.text;
    student.age = [NSNumber numberWithInteger:[self.ageTextField.text integerValue]];
    
    [self addStudentFromController:student];
    */
    
    
    
    //[[NSCoreData sharedManager] addRandomStudent];
    
    NSMainTableViewController* mvc = [[self.navigationController viewControllers] objectAtIndex:0];
    
    [mvc.tableView reloadData];
    
    
    if ([self.managedObjectContext save:nil]) {
        
    UIAlertView* alert =  [[UIAlertView alloc] initWithTitle:@"Succes!" message:@"Student add to Core Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
    
        [alert show];
    }
}

- (void) deleteAndInsert{
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSStudent" inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    NSError* errors= nil;
    
    NSArray* array = [self.managedObjectContext executeFetchRequest:request error:&errors];
    
    
    
    for (NSStudent* student  in array ) {
        
        if ([student isEqual:self.student]) {
            [self.managedObjectContext deleteObject:student];
            
        }
    }
    [self.managedObjectContext save:nil];
    
    

    
}
@end
