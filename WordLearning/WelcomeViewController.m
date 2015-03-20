//
//  ViewController.m
//  WordLearning
//
//  Created by Khvorostov on 08/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "WelcomeViewController.h"

@implementation WelcomeViewController

NSArray *possibleAnswers;

-(void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *sourceForLanguages = @[@"None", @"French"];
    [[self languageSelectButton] addItemsWithTitles:sourceForLanguages];
    possibleAnswers = @[@"Choose one", @"Come oooonnn", @"None - is not an answer",@"You have to choose one!", @"You make me feel nervous"];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)nextButton:(id)sender {
    
    NSString *title = [[self.languageSelectButton selectedItem] title];
    switch (self.languageSelectButton.indexOfSelectedItem) {
        case 0:{
            
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"Reconsider your choice"];
            [alert setMessageText:possibleAnswers[arc4random() % possibleAnswers.count]];
            [alert setAlertStyle:NSInformationalAlertStyle];
            [alert runModal];
        }
            break;
        case 1:{
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_FIRST_TIME_APPLICATION_USED_KEY];
            [self dismissController:self];
        }
            
        default:
            break;
    }
}

@end
