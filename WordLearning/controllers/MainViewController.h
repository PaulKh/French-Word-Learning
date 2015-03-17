//
//  MainViewController.h
//  WordLearning
//
//  Created by Khvorostov on 11/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainViewController : NSViewController<NSAlertDelegate, NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)addNewWord:(id)sender;
@end
