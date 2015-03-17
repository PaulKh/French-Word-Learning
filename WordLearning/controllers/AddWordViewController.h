//
//  AddWordViewController.h
//  WordLearning
//
//  Created by Khvorostov on 16/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AddWordViewController : NSViewController
@property (weak) IBOutlet NSTextField *wordTextField;
@property (weak) IBOutlet NSTextField *translationTextField;
@property (unsafe_unretained) IBOutlet NSTextView *descriptionTextView;
@property (weak) IBOutlet NSButton *addButton;

@property (weak) IBOutlet NSPopUpButton *typeSelectionPopup;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)addWordPressed:(id)sender;
@end
