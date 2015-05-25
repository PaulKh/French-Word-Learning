//
//  AddWordViewController.h
//  WordLearning
//
//  Created by Khvorostov on 16/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DatabaseHandler.h"
#import "DismissViewProtocol.h"
@interface AddWordViewController : NSViewController
@property (strong, nonatomic) Dictionary *dictionary;

@property (weak) IBOutlet NSTextField *wordTextField;
@property (weak) IBOutlet NSTextField *translationTextField;
@property (strong) IBOutlet NSTextView *descriptionTextView;
@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *knowButton;
@property (weak) IBOutlet NSButton *dontKnowButton;
- (IBAction)knowPressed:(id)sender;
- (IBAction)dontKnowPressed:(id)sender;

@property (weak) IBOutlet NSPopUpButton *typeSelectionPopup;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)addWordPressed:(id)sender;
@property (weak) IBOutlet NSTextField *secondTranslationTextField;
@property (weak) IBOutlet NSTextField *thirdTranslationTextField;
@property (weak) IBOutlet NSTextField *forthTranslationTextField;
@property (weak) IBOutlet NSTextField *fifthTranslationTextField;

@property (strong) WordTranslationTuple *tupleToEdit;

@property (weak) id<DismissViewProtocol> dismissDelegate;

@end
