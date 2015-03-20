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

static DatabaseHandler *instance;

+(DatabaseHandler *) instance{
    if (instance == nil) {
        instance =  [[self alloc] init];
    }
    return instance;
}

-(Dictionary *)addNewDictionary:(NSString *)name{
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
                            wordType:(WordType *)type
                          dictionary:(Dictionary *)dictionary
                         description:(NSString *)description{
    NSManagedObjectContext *managedObjectContext = [[DataBaseInitiator instance] managedObjectContext];
    WordTranslationTuple *wordTranslationTuple = [NSEntityDescription
                              insertNewObjectForEntityForName:@"WordTranslationTuple"
                              inManagedObjectContext:managedObjectContext];
    wordTranslationTuple.word = word;
    wordTranslationTuple.translations = translations;
    wordTranslationTuple.wordDescription = description;
    wordTranslationTuple.type = [[NSNumber alloc] initWithInt:type.number];
    wordTranslationTuple.translations = translations;
    wordTranslationTuple.createdAt = [NSDate date];
    [dictionary addWordTranslationTupleObject:wordTranslationTuple];
    [word setTuple:wordTranslationTuple];
    [self saveContext];
    return wordTranslationTuple;
}
-(void)saveContext{
    NSManagedObjectContext *managedObjectContext = [[DataBaseInitiator instance] managedObjectContext];
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}
-(NSArray *)dictionaries{
    NSManagedObjectContext *context = [[DataBaseInitiator instance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Dictionary" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    return fetchedObjects;
}
-(NSArray *)wordTuplesForDictionary:(Dictionary *)dictionary{
    NSManagedObjectContext *context = [[DataBaseInitiator instance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"WordTranslationTuple" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dictionary.name == %@", dictionary.name];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    return fetchedObjects;
    
}

- (void) deleteTuple:(WordTranslationTuple *)object{
    NSManagedObjectContext *context = [[DataBaseInitiator instance] managedObjectContext];
    for (NSManagedObject *translation in object.translations) {
        [context deleteObject:translation];
    }
    [context deleteObject:object.word];
    [context deleteObject:object];
    [self saveContext];
}





@end
