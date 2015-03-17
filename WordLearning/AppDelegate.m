//
//  AppDelegate.m
//  WordLearning
//
//  Created by Khvorostov on 08/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "AppDelegate.h"
#import "DataBaseInitiator.h"

@interface AppDelegate ()

- (IBAction)saveAction:(id)sender;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    // Save changes in the application's managed object context before the application terminates.
    return [[DataBaseInitiator instance] saveChangesBeforeExit:sender];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return YES;
}

@end
