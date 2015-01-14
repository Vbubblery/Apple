//
//  AppDelegate.h
//  Hash
//
//  Created by juncheng zhou on 5/22/14.
//
//

#import <Cocoa/Cocoa.h>
#import "FirstViewController.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) IBOutlet NSViewController *firstViewController;
- (IBAction)saveAction:(id)sender;
@end
