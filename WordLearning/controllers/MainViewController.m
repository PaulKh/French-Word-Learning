//
//  MainViewController.m
//  WordLearning
//
//  Created by Khvorostov on 11/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

-(void)viewDidAppear{
    [super viewDidAppear];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:IS_FIRST_TIME_APPLICATION_USED_KEY]){
        [self performSegueWithIdentifier:@"StartLearningSegue" sender:self];
    }
}

#pragma mark Create alert
-(void)createWelcomeAlert{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"YES"];
    [alert addButtonWithTitle:@"NO, quit"];
    [alert setMessageText:@"Welcome to learning language tool. Here you create dictionaries for languages you want to learn"];
//    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert beginSheetModalForWindow:[[self view] window] completionHandler:^(NSModalResponse returnCode) {
        if (NSModalResponseContinue == returnCode) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_FIRST_TIME_APPLICATION_USED_KEY];
        }
        else if(NSModalResponseCancel == returnCode){
            [[[self view] window] close];
        }
    }];
}
- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    if (NSAlertFirstButtonReturn == returnCode) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_FIRST_TIME_APPLICATION_USED_KEY];
    }
    else{
        [[[self view] window] close];
    }
}

- (IBAction)addNewWord:(id)sender {
}
// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [_tableContents count];
}
@end
