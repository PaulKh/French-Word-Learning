//
//  DatabaseHandler.m
//  WordLearning
//
//  Created by Khvorostov on 10/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//
#import "DataBaseInitiator.h"
#import "DatabaseHandler.h"

@implementation DatabaseHandler

-(Dictionary *)addNewDictionary:(NSString *)name;{
    NSManagedObjectContext *managedObjectContext = [[DataBaseInitiator instance] managedObjectContext];
    Dictionary *dictionary = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"Dictionary"
                                       inManagedObjectContext:managedObjectContext];
    dictionary.name = name;
    
    return dictionary;
}

-(Word *)addNewWord:(NSString *)word language:(LanguageEnum)languageEnum{
    NSManagedObjectContext *managedObjectContext = [[DataBaseInitiator instance] managedObjectContext];
    Word *tempWord = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Word"
                              inManagedObjectContext:managedObjectContext];
    tempWord.word = word;
    tempWord.language = [[NSNumber alloc] initWithInt:languageEnum];
    
    return tempWord;
}

-(WordTranslationTuple *)addNewTuple:(Word *)word
                        translations:(NSSet *)translations
                            wordType:(WordTypeManager *)type
                          dictionary:(Dictionary *)dictionary
                         description:(NSString *)description{
    NSManagedObjectContext *managedObjectContext = [[DataBaseInitiator instance] managedObjectContext];
    WordTranslationTuple *wordTranslationTuple = [NSEntityDescription
                              insertNewObjectForEntityForName:@"WordTranslationTuple"
                              inManagedObjectContext:managedObjectContext];
    wordTranslationTuple.word = word;
    wordTranslationTuple.translations = translations;
    wordTranslationTuple.wordDescription = description;
    wordTranslationTuple.type = [type wordType];
    
    
    
    return dictionary;
    
}
-(void)saveContext{
    NSManagedObjectContext *managedObjectContext = [[DataBaseInitiator instance] managedObjectContext];
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
@end
