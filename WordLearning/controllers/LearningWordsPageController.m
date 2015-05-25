//
//  LearningWordsPageController.m
//  WordLearning
//
//  Created by Khvorostov on 18/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "LearningWordsPageController.h"
#import "WordTranslationTuple.h"
#import "Word.h"
#import "PageEntityViewController.h"
#import "RootViewPage.h"

@interface LearningWordsPageController ()

@end

@implementation LearningWordsPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}
- (void)viewDidAppear{
    [super viewDidAppear];
    
    // Do view setup here.
}
- (void)viewWillDisappear{
    [super viewWillDisappear];
    if (self.dismissDelegate != nil) {
        [self.dismissDelegate didDismissModalView];
    }
}
- (NSViewController *)pageController:(NSPageController *)pageController
         viewControllerForIdentifier:(NSString *)identifier{
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    PageEntityViewController *vc = [storyboard instantiateControllerWithIdentifier:@"PageEntityViewController"];
    vc.tuple = [[pageController arrangedObjects] objectAtIndex:[identifier integerValue]];
    if([self.view isMemberOfClass: [RootViewPage class]]){
        ((RootViewPage *)self.view).keyPressedListener = self;
    }
    return vc;
}
- (NSString *)pageController:(NSPageController *)pageController
         identifierForObject:(id)object{
    if ([object isKindOfClass:[WordTranslationTuple class]]){
        return [[NSNumber numberWithInteger:[[pageController arrangedObjects] indexOfObject:object]] stringValue];
    }
    else return @"";
}
//- (NSString *)identifierForWord:(WordTranslationTuple *)identifier{
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
//    [formater setDateFormat:@"ddMMyyyyHHmmss"];
//    return [identifier.word.word stringByAppendingString:[formater stringFromDate:identifier.createdAt]];
//}
- (void)pageControllerWillStartLiveTransition:(NSPageController *)pageController{}
- (void)pageController:(NSPageController *)pageController didTransitionToObject:(id)object{}
- (void)pageControllerDidEndLiveTransition:(NSPageController *)pageController{
    [pageController completeTransition];
}
- (void)moveLeft{    
    [self moveToPoistion:(int)[self selectedIndex] - 1 < 0 ? 0 : (int)[self selectedIndex] - 1];
}
- (void)moveRight{
    [self moveToPoistion:(int)[self selectedIndex] + 1 > [self arrangedObjects].count - 1 ? (int)[self arrangedObjects].count - 1 : (int)[self selectedIndex] + 1];
}
-(void)moveToPoistion:(int)position{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [[self animator] setSelectedIndex:position];
    } completionHandler:^{
        [self completeTransition];
    }];
}
- (void)keyPressed:(NSEvent *)theEvent{
    switch ([theEvent keyCode]) {
        case 49:
            [((PageEntityViewController *)[self selectedViewController]) spacePressed];
            //i know
            break;
        case 123:
            [self moveLeft];
            //move left
            break;
        case 124:
            [self moveRight];
            //move right
            break;
        case 51:
            //i dont know
            [((PageEntityViewController *)[self selectedViewController]) backspacePressed];
            break;
        default:
            break;
    }
    //    ([theEvent keyCode] == 49) { //Spacebar keyCode is 49
    //        NSLog(@"Time is: %@", [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle]);
    //    }
}

@end
