//
//  NSStudent.h
//  CoreData UNKNOWN
//
//  Created by Nik on 01.10.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NObject.h"

@class NSCourse;

@interface NSStudent : NObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSSet *courses;
@property (nonatomic, retain) NSCourse *cours;


@end

@interface NSStudent (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(NSCourse *)value;
- (void)removeCoursesObject:(NSCourse *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
