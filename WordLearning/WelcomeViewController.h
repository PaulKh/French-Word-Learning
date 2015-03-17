//
//  ViewController.h
//  WordLearning
//
//  Created by Khvorostov on 08/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface WelcomeViewController : NSViewController

@property (weak) IBOutlet NSPopUpButton *languageSelectButton;

- (IBAction)nextButton:(id)sender;

@end

