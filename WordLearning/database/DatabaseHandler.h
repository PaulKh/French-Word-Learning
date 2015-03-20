//
//  DatabaseHandler.h
//  WordLearning
//
//  Created by Khvorostov on 10/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageEnum.h"
#import "Word.h"
#import "Dictionary.h"
#import "WordType.h"
#import "WordTranslationTuple.h"

#import <CoreData/CoreData.h>

@interface DatabaseHandler : NSObject

-(Dictionary *)addNewDictionary:(NSString *)name;
-(Word *)addNewWord:(NSString *)word language:(LanguageEnum)languageEnum;

-(WordTranslationTuple *)addNewTuple:(Word *)word
                        translations:(NSSet *)translations
                            wordType:(WordType *)type
                          dictionary:(Dictionary *)dictionary
                         description:(NSString *)description;
-(void)saveContext;
+(DatabaseHandler *) instance;
-(NSArray *)wordTuplesForDictionary:(Dictionary *)dictionary;
-(NSArray *)dictionaries;
-(void)deleteTuple:(WordTranslationTuple *)object;

@end
