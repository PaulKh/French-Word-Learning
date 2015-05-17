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
//    for (WordTranslationTuple *tuple in self.tuples) {
//        tuple.word.word = [tuple.word.word stringByReplacingOccurrencesOfString:@"(n)" withString:@"(m)"];
//    }
//    [[DatabaseHandler instance] saveContext];
    [self.headerView setDelegate:self];
    
//    NSURL * documentsDirectory = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
//    NSURL *file = [documentsDirectory URLByAppendingPathComponent:@"contacts.xls"];
//    NSString* string = @"<table><tr><td>FOO</td><td>BAR</td></tr></table>";
//    [string writeToFile:file.path atomically:YES encoding:NSUTF8StringEncoding error:nil];
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

- (IBAction)addNewWord:(id)sender {
}
// The only essential/required tableview dataSource method
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.tuples.count;
}
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    WordTranslationTuple *tuple = [self.tuples objectAtIndex:row];
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
    WordTranslationTuple *tuple = [self.tuples objectAtIndex:row];
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
        NSString *translations = @"";
        for (Word *word in tuple.translations) {
            translations = [[translations stringByAppendingString:word.word] stringByAppendingString:@"\n"];
        }
        translations = [translations substringToIndex:translations.length - 1];
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
    }
}
- (void)didDismissModalView{
    self.tuples = [NSMutableArray arrayWithArray:[[DatabaseHandler instance] wordTuplesForDictionary:self.dictionary]];
    [self.tableView reloadData];
    return;
}
@end
