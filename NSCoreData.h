//
//  NSCoreData.h
//  CoreData UNKNOWN
//
//  Created by Nik on 30.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSStudent.h"
#import "NSCourse.h"

@interface NSCoreData : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController2;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (NSCoreData*) sharedManager ;


- (NSFetchedResultsController*) getAllStudents;
- (void) deleteAllObjects;
- (void) deleteAllCourses;
- (NSStudent*) addRandomStudent;
-  (void) addAllCourses;
- (NSArray*) getStudentsFromIosCourse;
- (NSArray*) getCourses;
- (void) setIosCourse;
- (void) printAllObjects;
- (void) addToIOS ;
- (void) addToAndroid;
- (void) addToJavaScript;
- (void) printAllCourses;
- (NSFetchedResultsController*) getStudentsFromCourse:(NSString*) course;
@end
