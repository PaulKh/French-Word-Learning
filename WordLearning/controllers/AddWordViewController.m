//
//  AddWordViewController.m
//  WordLearning
//
//  Created by Khvorostov on 16/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "AddWordViewController.h"
#import "WordTypeManager.h"
#import "LanguageEnum.h"
@interface AddWordViewController()

-(void)showAlert:(NSString *)message;

@end
@implementation AddWordViewController

NSArray *wordTypes;

-(void)viewDidLoad{
    [super viewDidLoad];
    wordTypes = [[WordTypeManager instance] allWordTypesTitles];
    [[self typeSelectionPopup] addItemsWithTitles:wordTypes];
    [self prepareEditingMode];
}

-(void)prepareEditingMode{
    if (self.tupleToEdit != nil) {
        [self.addButton setTitle:@"Save changes"];
        self.wordTextField.stringValue = self.tupleToEdit.word.word;
        self.descriptionTextView.string = self.tupleToEdit.wordDescription;
        int counter = 1;
        for (Word *translation in self.tupleToEdit.translations) {
            if (counter == 1) {
                self.translationTextField.stringValue = translation.word;
            }
            else if (counter == 2) {
                self.secondTranslationTextField.stringValue = translation.word;
            }
            else if (counter == 3) {
                self.thirdTranslationTextField.stringValue = translation.word;
            }
            else if (counter == 4) {
                self.forthTranslationTextField.stringValue = translation.word;
            }
            else if (counter == 5) {
                self.fifthTranslationTextField.stringValue = translation.word;
            }
            counter++;
        }
        for (NSString *type in wordTypes) {
            if ([type isEqualToString:[[WordTypeManager instance] wordTypeById:[self.tupleToEdit.type intValue]].name]) {
                [self.typeSelectionPopup selectItemAtIndex:[wordTypes indexOfObject:type]];
                break;
            }
        }
        
    }
}
-(void)viewDidAppear{
    [super viewDidAppear];
    [[[self view] window] makeFirstResponder:self.addButton];
}


- (IBAction)cancelPressed:(id)sender {
    [self dismissController:self];
}

- (IBAction)addWordPressed:(id)sender {
    NSString *word = [[[self wordTextField] stringValue] stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceCharacterSet]];
    if (word == nil || word.length == 0) {
        [self showAlert:@"Please add a word"];
        return;
    }
    NSMutableArray *translations = [[NSMutableArray alloc] init];
    NSString *transl1 = [[self.translationTextField stringValue] stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceCharacterSet]];
    NSString *transl2 = [[self.secondTranslationTextField stringValue] stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceCharacterSet]];
    NSString *transl3 = [[self.thirdTranslationTextField stringValue] stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceCharacterSet]];
    NSString *transl4 = [[self.forthTranslationTextField stringValue]stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceCharacterSet]];
    NSString *transl5 = [[self.fifthTranslationTextField stringValue]stringByTrimmingCharactersInSet:
    [NSCharacterSet whitespaceCharacterSet]];
    if (transl1 != nil && transl1.length != 0) {
        [translations addObject:transl1];
    }
    if (transl2 != nil && transl2.length != 0) {
        [translations addObject:transl2];
    }
    if (transl3 != nil && transl3.length != 0) {
        [translations addObject:transl3];
    }
    if (transl4 != nil && transl4.length != 0) {
        [translations addObject:transl4];
    }
    if (transl5 != nil && transl5.length != 0) {
        [translations addObject:transl5];
    }
    if (translations.count == 0) {
        [self showAlert:@"Add at least one translation"];
        return;
    }
    Word *wordEntity = [[DatabaseHandler instance] addNewWord:word language:French];
    NSMutableArray *translationsEntities = [[NSMutableArray alloc] init];
    for (NSString *translation in translations) {
        [translationsEntities addObject:[[DatabaseHandler instance] addNewWord:translation language:English]];
    }
    
    NSSet *translationsSet = [[NSSet alloc] init];
    translationsSet = [translationsSet setByAddingObjectsFromArray:translationsEntities];
    [[DatabaseHandler instance] addNewTuple:wordEntity translations:translationsSet wordType:[[WordTypeManager instance] wordTypeByName:[wordTypes objectAtIndex:[self.typeSelectionPopup indexOfSelectedItem]]]   dictionary:self.dictionary description:[[self.descriptionTextView string] stringByTrimmingCharactersInSet:
     [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    [self saveChanges];
    [self.dismissDelegate didDismissModalView];
    [self dismissController:self];
}
-(void)saveChanges{
    if (self.tupleToEdit != nil) {
        [[DatabaseHandler instance] deleteTuple:self.tupleToEdit];
    }
}
-(void)showAlert:(NSString *)message{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:message];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert runModal];
}

@end
