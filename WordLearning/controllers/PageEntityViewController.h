//
//  PageEntityViewController.h
//  WordLearning
//
//  Created by Khvorostov on 19/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WordTranslationTuple.h"

@interface PageEntityViewController : NSViewController
@property (weak) IBOutlet NSTextField *wordLabel;
- (IBAction)iKnowClicked:(id)sender;
- (IBAction)iDontKnowClicked:(id)sender;

@property (unsafe_unretained) IBOutlet NSTextView *descriptionTextView;
@property (weak) IBOutlet NSScrollView *translationScrollView;
@property (weak) IBOutlet NSScrollView *descriptionScrollView;
@property (weak) IBOutlet NSButton *IKnowButton;
@property (weak) IBOutlet NSButton *iDontKnowButton;
@property (weak) IBOutlet NSTextField *translationTitleLabel;
@property (weak) IBOutlet NSTextField *descriptionTitleLabel;
@property (weak) IBOutlet NSTextField *whenToRepeatLabel;

@property (unsafe_unretained) IBOutlet NSTextView *translationsTextView;
@property (strong) WordTranslationTuple *tuple;
-(void)spacePressed;
-(void)backspacePressed;
@end
