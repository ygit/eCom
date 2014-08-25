//
//  AppDelegate.h
//  eCom
//
//  Created by yogesh singh on 14/08/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (NSURL *) applicationDocumentsDirectory;
- (NSArray *) getAllRecords;


@end
