//
//  MainViewController.m
//  WordLearning
//
//  Created by Khvorostov on 11/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "MainViewController.h"
#import "AddWordViewController.h"
#import "WordTypeManager.h"
#import "SortOrder.h"
#import "LearningWordsPageController.h"
#import "LearningHelper.h"
@implementation MainViewController

int sortedByColumnNumber = 4;
SortOrder sortOrder = Ascending;

-(void)viewDidLoad{
    [super viewDidLoad];
    NSArray * dicts = [[DatabaseHandler instance] dictionaries];
    self.tuples = [[NSMutableArray alloc] init];
    if (dicts.count > 0) {
        self.dictionary = dicts[0];
        self.tuples =[NSMutableArray arrayWithArray:[[DatabaseHandler instance] wordTuplesForDictionary:self.dictionary]];
    }
    [self.headerView setDelegate:self];
    [self.tableView setSelectionHighlightStyle: NSTableViewSelectionHighlightStyleNone];
    [self updateTitle];
}
-(void)updateTitle{
    int count = (int)[[self wordsToLearn] count];
    [self.wordsToLearnLabel setStringValue:[NSString stringWithFormat:@"Words to learn: %d", count]];
    if (count == 0) {
        [self.learnButton setEnabled:NO];
    }
    else [self.learnButton setEnabled:YES];
}
-(void)viewDidAppear{
    [super viewDidAppear];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:IS_FIRST_TIME_APPLICATION_USED_KEY]){
        [self performSegueWithIdentifier:@"StartLearningSegue" sender:self];
    }
}
-(void)clickOnTableColumn:(int)tableColumn{
    if (tableColumn != 1 && tableColumn != 3 && tableColumn != 4) {
        return;
    }
    if (tableColumn == sortedByColumnNumber) {
        sortOrder = (sortOrder == Ascending) ? Descending : Ascending;
    }
    else{
        sortedByColumnNumber = tableColumn;
        sortOrder = Ascending;
    }
    if (tableColumn == 1) {
        self.tuples = [NSMutableArray arrayWithArray:[self.tuples sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *firstName = [[(WordTranslationTuple*)a word].word lowercaseString];
            NSString *secondName = [[(WordTranslationTuple*)b word].word lowercaseString];
            if(sortOrder == Ascending)
                return [firstName compare:secondName];
            else return [secondName compare:firstName];
        }]];
        [self.tableView reloadData];
    }
    else if (tableColumn == 3){
        self.tuples = [NSMutableArray arrayWithArray:[self.tuples sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *firstName = [[[WordTypeManager instance] wordTypeById:[[(WordTranslationTuple*)a type] intValue]].name lowercaseString];
            NSString *secondName = [[[WordTypeManager instance] wordTypeById:[[(WordTranslationTuple*)b type] intValue]].name lowercaseString];
            if(sortOrder == Ascending)
                return [firstName compare:secondName];
            else return [secondName compare:firstName];
        }]];
        [self.tableView reloadData];
    }
    else if (tableColumn == 4){
        self.tuples = [NSMutableArray arrayWithArray:[self.tuples sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSDate *firstName = [(WordTranslationTuple*)a createdAt];
            NSDate *secondName = [(WordTranslationTuple*)b createdAt];
            if(sortOrder == Ascending)
                return [firstName compare:secondName];
            else return [secondName compare:firstName];
        }]];
        [self.tableView reloadData];
    }
    
}
#pragma mark Create alert
-(void)createWelcomeAlert{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"YES"];
    [alert addButtonWithTitle:@"NO, quit"];
    [alert setMessageText:@"Welcome to learning language tool. Here you create dictionaries for languages you want to learn"];
//    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert beginSheetModalForWindow:[[self view] window] completionHandler:^(NSModalResponse returnCode) {
        if (NSModalResponseContinue == returnCode) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_FIRST_TIME_APPLICATION_USED_KEY];
        }
        else if(NSModalResponseCancel == returnCode){
            [[[self view] window] close];
        }
    }];
}

- (void)alertDidEnd:(NSAlert *)alert returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    if (NSAlertFirstButtonReturn == returnCode) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IS_FIRST_TIME_APPLICATION_USED_KEY];
    }
    else{
        [[[self view] window] close];
    }
}
//- (BOOL)validateProposedFirstResponder:(NSResponder *)responder
//                              forEvent:(NSEvent *)event{
//    if (event.type == NSRightMouseDown) {
//        NSMenu *theMenu = [[NSMenu alloc] initWithTitle:@"Contextual Menu"];
//        [theMenu insertItemWithTitle:@"Edit" action:@selector(edit) keyEquivalent:@"" atIndex:0];
//        [theMenu insertItemWithTitle:@"Delete" action:@selector(delete) keyEquivalent:@"" atIndex:1];
//        
//        [NSMenu popUpContextMenu:theMenu withEvent:event forView:self.tableView];
//    }
//    return NO;
//}
//-(void)delete{
//    NSInteger k = [self.tableView clickedRow];
//}
//-(void)edit{
//    
//}
- (IBAction)editRowAction:(id)sender {
    int selectedRow = (int)[self.tableView clickedRow];
    WordTranslationTuple *tuple = [self.tuples objectAtIndex:selectedRow];
    [self performSegueWithIdentifier:@"EditWordSegue" sender:tuple];
}

- (IBAction)deleteRowAction:(id)sender {
    int selectedRow = (int)[self.tableView clickedRow];
    if (selectedRow >= 0 && selectedRow < self.tuples.count) {
        WordTranslationTuple *tuple = [self.tuples objectAtIndex:selectedRow];
        [[DatabaseHandler instance] deleteTuple:tuple];
        [self.tuples removeObject:tuple];
        [self.tableView reloadData];
    }
    
}

- (IBAction)learnButtonPressed:(id)sender {
    NSMutableArray *array = [self wordsToLearn];
    if ([array count] != 0) {
        [[LearningHelper instance] shuffle:array];
        [self performSegueWithIdentifier:@"ToPageControllerSegueIdentifier" sender:array];
    }
}

- (IBAction)addNewWord:(id)sender {
}

- (IBAction)updateWordsToLearnLabel:(id)sender {
}

- (IBAction)searchText:(id)sender {
    NSString *string =  [self.searchTextField.stringValue stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    if ([string isEqualToString:@""]) {
        self.filteredTuples = nil;
    }
    else{
        self.filteredTuples = [[NSMutableArray alloc] init];
        for (WordTranslationTuple *tuple in self.tuples) {
            //remove accents
            NSData *data = [tuple.word.word dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *newStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            if ([newStr containsString:string]) {
                [self.filteredTuples addObject:tuple];
            }
        }
    }
    [self.tableView reloadData];
}
// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    return self.filteredTuples == nil ? self.tuples.count : self.filteredTuples.count;
}
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    WordTranslationTuple *tuple = self.filteredTuples == nil ? [self.tuples objectAtIndex:row] : [self.filteredTuples objectAtIndex:row];
    int linesCounter = 1;
    for (int i = 0; i < tuple.wordDescription.length; i++) {
        if ([tuple.wordDescription characterAtIndex:i] == '\n') {
            linesCounter++;
        }
    }
    if (tuple.translations.count > linesCounter) {
        return 17 * tuple.translations.count;
    }
    else if(linesCounter > 8)
        return 8 * 17;
    else return 17 * linesCounter;
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // Group our "model" object, which is a dictionary
//    NSDictionary *dictionary = [_tableContents objectAtIndex:row];
    
    // In IB the tableColumn has the identifier set to the same string as the keys in our dictionary
    NSString *identifier = [tableColumn identifier];
    WordTranslationTuple *tuple = self.filteredTuples == nil ? [self.tuples objectAtIndex:row] : [self.filteredTuples objectAtIndex:row];
    if ([identifier isEqualToString:@"NumberId"]) {
        NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
        textField.objectValue = [NSString stringWithFormat:@"%ld",row + 1];
        return textField;
    }
    else if ([identifier isEqualToString:@"WordId"]) {
        NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
        textField.objectValue = tuple.word.word;
        return textField;
    } else if ([identifier isEqualToString:@"TranslationsId"]) {
        NSScrollView *textView = [tableView makeViewWithIdentifier:identifier owner:self];
        NSString *translations = [tuple allTranslationsInASingleString];
        if (translations != nil) {
            ((NSTextView *)[textView documentView]).string = translations;
        }
        return textView;
    } else if ([identifier isEqualToString:@"TypeId"]) {
        NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
        textField.stringValue = [[WordTypeManager instance] wordTypeById:[tuple.type intValue]].name;
        return textField;
    }else if ([identifier isEqualToString:@"DateId"]) {
        NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        [df setDateFormat:@"dd MMM yyyy"];

        textField.stringValue = [df stringFromDate:tuple.createdAt];
        return textField;
    }else if([identifier isEqualToString:@"LearntId"]){
        NSTextField *textField = [tableView makeViewWithIdentifier:identifier owner:self];
        textField.objectValue = tuple.numberOfTrainings;
        return textField;
    }else if ([identifier isEqualToString:@"DescriptionId"]) {
        NSScrollView *textView = [tableView makeViewWithIdentifier:identifier owner:self];
        if (tuple.wordDescription != nil) {
            ((NSTextView *)[textView documentView]).string = tuple.wordDescription;
        }
        return textView;
    }else {
        NSAssert1(NO, @"Unhandled table column identifier %@", identifier);
    }
    return nil;
}

- (void)prepareForSegue:(NSStoryboardSegue*)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddWordSegueID"]) {
        ((AddWordViewController *)segue.destinationController).dismissDelegate = self;
        ((AddWordViewController *)segue.destinationController).dictionary = self.dictionary;
    }
    else if ([segue.identifier isEqualToString:@"EditWordSegue"]){
        ((AddWordViewController *)segue.destinationController).tupleToEdit = sender;
        ((AddWordViewController *)segue.destinationController).dismissDelegate = self;
        ((AddWordViewController *)segue.destinationController).dictionary = self.dictionary;
    }else if([segue.identifier isEqualToString:@"ToPageControllerSegueIdentifier"]){
                LearningWordsPageController *pageController = ((LearningWordsPageController *)segue.destinationController);
        pageController.dismissDelegate = self;
        [pageController setArrangedObjects:sender];
        [pageController setTransitionStyle:NSPageControllerTransitionStyleStackBook];
        [pageController setDelegate:pageController];
        
    }
}
- (void)didDismissModalView{
    self.tuples = [NSMutableArray arrayWithArray:[[DatabaseHandler instance] wordTuplesForDictionary:self.dictionary]];
    [self.tableView reloadData];
    [self updateTitle];
    return;
}
-(NSMutableArray *)wordsToLearn{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (WordTranslationTuple *tuple in self.tuples) {
        if ([[LearningHelper instance] isWordNeedToBeLearnt:tuple]) {
            [array addObject:tuple];
        }
    }
    return array;
}
@end
