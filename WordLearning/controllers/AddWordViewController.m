//
//  AddWordViewController.m
//  WordLearning
//
//  Created by Khvorostov on 16/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "AddWordViewController.h"

@implementation AddWordViewController
-(void)viewDidAppear{
    [super viewDidAppear];
    [[[self view] window] makeFirstResponder:self.addButton];
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissController:self];
}

- (IBAction)addWordPressed:(id)sender {
}
@end
