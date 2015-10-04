//
//  NSCourse.h
//  CoreData UNKNOWN
//
//  Created by Nik on 01.10.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NObject.h"

@class NSStudent;

@interface NSCourse : NObject

@property (nonatomic, retain) NSString * nameOfCourse;
@property (nonatomic, retain) NSString * mentorName;
@property (nonatomic, retain) NSSet *students;
@end

@interface NSCourse (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(NSStudent *)value;
- (void)removeStudentsObject:(NSStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
