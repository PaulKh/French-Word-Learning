//
//  MainWindowController.m
//  WordLearning
//
//  Created by Khvorostov on 10/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "MainWindowController.h"
#import "WelcomeViewController.h"


@implementation MainWindowController
- (void)windowDidLoad {
    [super windowDidLoad];
//    [self createWelcomeAlert];
}
#pragma mark Create alert
-(void)createWelcomeAlert{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"YES"];
    [alert addButtonWithTitle:@"NO, quit"];
    [alert setMessageText:@"Welcome to learning language tool. Here you create dictionaries for languages you want to learn"];
    //    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse returnCode) {
        if (NSModalResponseContinue == returnCode) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_FIRST_TIME_APPLICATION_USED_KEY];
        }
        else if(NSModalResponseCancel == returnCode){
            [NSApp terminate:self];
        }
    }];
}
@end
