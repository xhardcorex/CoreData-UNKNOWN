//
//  NSCoreData.m
//  CoreData UNKNOWN
//
//  Created by Nik on 30.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "NSCoreData.h"
#import "NSStudent.h"
#import "NSCourse.h"

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

static NSString* carModelNames[] = {
    @"Dodge", @"Toyota", @"BMW", @"Lada", @"Volga"
};






@implementation NSCoreData

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsController = _fetchedResultsController;

+ (NSCoreData*) sharedManager {
    
    static NSCoreData* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NSCoreData alloc] init];
    });
    
    return manager;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            
            
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData_UNKNOWN" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData_UNKNOWN.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Application's Documents directory

- (NSFetchedResultsController*) getAllStudents{
    
    
   
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSStudent"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];

    
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = aFetchedResultsController;
    
   
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error description]);
        abort();
    }
    
    return aFetchedResultsController;
}
- (NSFetchedResultsController*) getStudentsFromCourse:(NSString*) course{
    
    
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSCourse"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"nameOfCourse" ascending:YES];
   [fetchRequest setSortDescriptors:@[nameDescription]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"nameOfCourse == %@",course];
    
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error description]);
        abort();
    }
    
    return aFetchedResultsController;
    
}

- (void) deleteAllObjects{
    
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NObject" inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    NSError* errors= nil;
    
    NSArray* array = [self.managedObjectContext executeFetchRequest:request error:&errors];
    
    
    
    for (NSObject* object  in array ) {
        
[self.managedObjectContext deleteObject:object];
        
    }
     [self.managedObjectContext save:nil];
    
    
}
- (void) deleteAllCourses{
    
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSCourse" inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    NSError* errors= nil;
    
    NSArray* array = [self.managedObjectContext executeFetchRequest:request error:&errors];
    
    
    
    for (NSCourse* course  in array ) {
        
        [self.managedObjectContext deleteObject:course];
        
    }
    
    [self.managedObjectContext save:nil];
    
    
}

- (NSStudent*) addRandomStudent {
    
    NSStudent* student =
    [NSEntityDescription insertNewObjectForEntityForName:@"NSStudent"
                                  inManagedObjectContext:self.managedObjectContext];
    student.firstName = firstNames[arc4random_uniform(50)];
    student.lastName = lastNames[arc4random_uniform(50)];
    student.age = [NSNumber numberWithInt:arc4random()%50];
   
    
    
    [self.managedObjectContext save:nil];
    return student;
}
-  (void) addAllCourses {
    
    NSCourse* course1 =
    [NSEntityDescription insertNewObjectForEntityForName:@"NSCourse"
                                  inManagedObjectContext:self.managedObjectContext];
    course1.nameOfCourse  = @"IOS";
    
    course1.mentorName = @"Nik Shebeda";
    
    NSCourse* course2 =
    [NSEntityDescription insertNewObjectForEntityForName:@"NSCourse"
                                  inManagedObjectContext:self.managedObjectContext];
    course2.nameOfCourse  = @"Android";
    
    course2.mentorName = @"Nazar Humenuk";
    
    
    NSCourse* course3 = [NSEntityDescription insertNewObjectForEntityForName:@"NSCourse"
                                  inManagedObjectContext:self.managedObjectContext];
    course3.nameOfCourse  = @"Java Script";
    
    course3.mentorName = @"Artem Grechnyi";
    
    
    
    NSError* error = nil;
    
    if(![self.managedObjectContext save:&error]){
        
        NSLog(@"%@",[error localizedDescription]);
        
    }
    
    
  
}
- (NSArray*) getStudentsFromIosCourse{
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSCourse"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"nameOfCourse" ascending:YES];
    [fetchRequest setSortDescriptors:@[nameDescription]];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"nameOfCourse == 'IOS'"];
    
    [fetchRequest setPredicate:predicate];
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    NSCourse* course = [results objectAtIndex:0];
    
    NSArray* array = [course.students allObjects];
    return array ;
}
- (NSFetchedResultsController*) getCourses{
    
    
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSCourse" inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
   
  //  NSError* errors= nil;
    
    //NSArray* array = [self.managedObjectContext executeFetchRequest:request error:&errors];
    
    
    
    /*for (NSCourse* course  in array ) {
        
        NSLog(@"%@ %@ %lu",course.mentorName,course.nameOfCourse,(unsigned long)[course.students count]);
        
        
        
    }*/
    NSSortDescriptor* nameDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"nameOfCourse" ascending:YES];
    
    [request setSortDescriptors:@[nameDescriptor]];
    

    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error description]);
        abort();
    }
    
    return aFetchedResultsController;
    
}




- (void) printAllObjects {
 
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NObject" inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    NSError* errors= nil;
    
    NSArray* array = [self.managedObjectContext executeFetchRequest:request error:&errors];
    
    NSLog(@"COURSE COUNT = %d",[array count]);
    
    for (id object  in array ) {
        
        
        if ([object isKindOfClass:[NSStudent class]]) {
            
        
            
            NSStudent* student = (NSStudent*) object;
            
            NSArray* courses = [student.courses allObjects];
            
            
            NSLog(@"Student: %@ %@ %@ ", student.firstName, student.lastName, student.age);
            for (NSCourse* cours in courses ) {
                NSLog(@" %@ %@  Course:  %@ Mentor %@", student.firstName, student.lastName,cours.nameOfCourse,cours.mentorName  );
                
            }
            
        } else if ([object isKindOfClass:[NSCourse class]]) {
            
            NSCourse* course = (NSCourse*) object;
            NSLog(@"Course : %@ %@",course.nameOfCourse,course.mentorName);
            
        }         //NSLog(@"%@", object);
    }
    
    
    
}

- (void) addToIOS {
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSStudent"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
   
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@" age <= %d",25];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    NSError* errors= nil;
    
    NSArray* arrayOfStudents = [self.managedObjectContext executeFetchRequest:fetchRequest error:&errors];
    
    NSFetchRequest* fetchRequest2 = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description2 =
    [NSEntityDescription entityForName:@"NSCourse"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest2 setEntity:description2];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSPredicate* predicate2 = [NSPredicate predicateWithFormat:@"nameOfCourse == 'IOS' "];
    
    [fetchRequest2 setPredicate:predicate2];
    
    
    NSArray* courses = [self.managedObjectContext executeFetchRequest:fetchRequest2 error: nil];
    
    if ([courses count] >0) {
        
        
        NSCourse* courseIOS = [courses objectAtIndex:0];
        
        for (NSStudent* student in arrayOfStudents) {
            
            [student addCoursesObject:courseIOS];
            
        }
    }
    
    
    
    
    [self.managedObjectContext save:&errors];

}
- (void) addToAndroid {
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSStudent"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@" age > %d AND age <= %d",25,35];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    NSError* errors= nil;
    
    NSArray* arrayOfStudents = [self.managedObjectContext executeFetchRequest:fetchRequest error:&errors];
    
    NSFetchRequest* fetchRequest2 = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description2 =
    [NSEntityDescription entityForName:@"NSCourse"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest2 setEntity:description2];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSPredicate* predicate2 = [NSPredicate predicateWithFormat:@"nameOfCourse == 'Android' "];
    
    [fetchRequest2 setPredicate:predicate2];
    
    
    NSArray* courses = [self.managedObjectContext executeFetchRequest:fetchRequest2 error: nil];
    
    if ([courses count]>0) {
     
        
        NSCourse* courseAndroid = [courses objectAtIndex:0];
        
        for (NSStudent* student in arrayOfStudents) {
            
            [student addCoursesObject:courseAndroid];
            
        }
    }
    
    
    
    
    [self.managedObjectContext save:&errors];
    
}

- (void) addToJavaScript {
    
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NSStudent"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSSortDescriptor* nameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@" age > %d",35];
    
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    NSError* errors= nil;
    
    NSArray* arrayOfStudents = [self.managedObjectContext executeFetchRequest:fetchRequest error:&errors];
    
    NSFetchRequest* fetchRequest2 = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description2 =
    [NSEntityDescription entityForName:@"NSCourse"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest2 setEntity:description2];
    
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSPredicate* predicate2 = [NSPredicate predicateWithFormat:@"nameOfCourse == 'Java Script' "];
    
    [fetchRequest2 setPredicate:predicate2];
    
    
    NSArray* courses = [self.managedObjectContext executeFetchRequest:fetchRequest2 error: nil];
    
    
    if ([courses count] >0) {
        
        NSCourse* courseJS = [courses objectAtIndex:0];
        
        for (NSStudent* student in arrayOfStudents) {
            
            [student addCoursesObject:courseJS];
            
        }
    }
    
    
    
    
    [self.managedObjectContext save:&errors];
    
}
- (void) printAllCourses{
    
    NSFetchRequest* request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"NCourse" inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    NSError* errors= nil;
    
    NSArray* array = [self.managedObjectContext executeFetchRequest:request error:&errors];
    
    
    
    for (NSCourse* course  in array ) {
        
        NSLog(@"%@",course.nameOfCourse);
        
    }
    // [self.managedObjectContext save:nil];
    
    
}




@end
