//
//  PageEntityViewController.m
//  WordLearning
//
//  Created by Khvorostov on 19/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "PageEntityViewController.h"
#import "Word.h"
#import "DatabaseHandler.h"
#import "LearningHelper.h"
#import "RootViewPage.h"

@interface PageEntityViewController ()

@end

@implementation PageEntityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.tuple.word.word);
    if (self.tuple != nil) {
        [self translationsTextView].string = [self.tuple allTranslationsInASingleString];
        self.descriptionTextView.string = [self.tuple wordDescription];
        self.wordLabel.stringValue = self.tuple.word.word;
        [self.wordLabel setSelectable:YES];
    }
    
    [[self translationsTextView] setDrawsBackground:NO];
    [self.translationScrollView setDrawsBackground:NO];
    [[self descriptionTextView] setDrawsBackground:NO];
    [self.descriptionScrollView setDrawsBackground:NO];
    [self.translationScrollView setHidden:YES];
    [self.descriptionScrollView setHidden:YES];
    [self.translationTitleLabel setHidden:YES];
    [self.descriptionTitleLabel setHidden:YES];
    // Do view setup here.
}

- (IBAction)iKnowClicked:(id)sender {
    if ([self.IKnowButton isHidden]) {
        return;
    }
    [self.IKnowButton setHidden:YES];
    int totalNumberOfRepeations = (int)[[[LearningHelper instance] daysBetweenRepeation] count] - 1;
    self.tuple.numberOfTrainings = [NSNumber numberWithInt:([self.tuple.numberOfTrainings intValue] == totalNumberOfRepeations) ? totalNumberOfRepeations : [self.tuple.numberOfTrainings intValue] + 1];
    self.tuple.lastTrainingDay = [NSDate date];
    [self updateWhenToRepeatLabel];
    [self showTranslationAndDescription];
}

- (void)updateWhenToRepeatLabel{
    int numberOfHoursTillRepeat = [[LearningHelper instance] whenToRepeatNextTime:self.tuple];
    if (numberOfHoursTillRepeat < 0) {
        return;
    }
    [self.whenToRepeatLabel setStringValue:[[NSString stringWithFormat:@"%d",numberOfHoursTillRepeat] stringByAppendingString:@" hours till repeat"]];

}
-(void)showTranslationAndDescription{
    [self.translationScrollView setHidden:NO];
    [self.descriptionScrollView setHidden:NO];
    [self.translationTitleLabel setHidden:NO];
    [self.descriptionTitleLabel setHidden:NO];
}
- (IBAction)iDontKnowClicked:(id)sender {
    if ([self.iDontKnowButton isHidden]) {
        return;
    }
    self.tuple.numberOfTrainings = [NSNumber numberWithInt:([self.tuple.numberOfTrainings intValue] == 0) ? 0 : [self.tuple.numberOfTrainings intValue] - 1];
    self.tuple.lastTrainingDay = [NSDate date];
    [[DatabaseHandler instance] saveContext];
    [self.iDontKnowButton setHidden:YES];
    [self.IKnowButton setHidden:YES];
    [self updateWhenToRepeatLabel];
    [self showTranslationAndDescription];
}
-(void)spacePressed{
    [self iKnowClicked:nil];
}
-(void)backspacePressed{
    [self iDontKnowClicked:nil];
}
@end
