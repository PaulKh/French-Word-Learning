//
//  WordTranslationTuple.m
//  WordLearning
//
//  Created by Khvorostov on 17/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "WordTranslationTuple.h"
#import "Dictionary.h"
#import "Word.h"


@implementation WordTranslationTuple

@dynamic audioSource;
@dynamic createdAt;
@dynamic numberOfTrainings;
@dynamic wordDescription;
@dynamic type;
@dynamic lastTrainingDay;
@dynamic dictionary;
@dynamic translations;
@dynamic word;

- (NSString *)allTranslationsInASingleString{
    NSString *translations = @"";
    for (Word *word in self.translations) {
        translations = [[translations stringByAppendingString:word.word] stringByAppendingString:@"\n"];
    }
    //remove last enter
    translations = [translations substringToIndex:translations.length - 1];
    return translations;
}
@end
