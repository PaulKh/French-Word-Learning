//
//  MainViewController.h
//  WordLearning
//
//  Created by Khvorostov on 11/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "DatabaseHandler.h"
#import "AddWordViewController.h"
#import "ClickableTableHeaderView.h"

@interface MainViewController : NSViewController<NSAlertDelegate, NSTableViewDelegate, NSTableViewDataSource, DismissViewProtocol, TableHeaderViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (strong, nonatomic) Dictionary *dictionary;
@property (strong, nonatomic) NSMutableArray *tuples;
- (IBAction)editRowAction:(id)sender;
- (IBAction)deleteRowAction:(id)sender;

@property (weak) IBOutlet ClickableTableHeaderView *headerView;
- (IBAction)addNewWord:(id)sender;
@end
