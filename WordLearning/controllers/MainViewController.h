//
//  MainViewController.h
//  WordLearning
//
//  Created by Khvorostov on 11/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DismissViewProtocol.h"
#import "DatabaseHandler.h"
#import "AddWordViewController.h"
#import "ClickableTableHeaderView.h"

@interface MainViewController : NSViewController<NSAlertDelegate, NSTableViewDelegate, NSTableViewDataSource, DismissViewProtocol, TableHeaderViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (strong, nonatomic) Dictionary *dictionary;
@property (strong, nonatomic) NSMutableArray *tuples;
@property (strong, nonatomic) NSMutableArray *filteredTuples;

- (IBAction)editRowAction:(id)sender;
- (IBAction)deleteRowAction:(id)sender;
- (IBAction)learnButtonPressed:(id)sender;
@property (weak) IBOutlet NSTextField *wordsToLearnLabel;
@property (weak) IBOutlet NSButton *learnButton;

@property (weak) IBOutlet ClickableTableHeaderView *headerView;
- (IBAction)addNewWord:(id)sender;
- (IBAction)updateWordsToLearnLabel:(id)sender;
- (IBAction)searchText:(id)sender;
@property (weak) IBOutlet NSSearchField *searchTextField;
@end
