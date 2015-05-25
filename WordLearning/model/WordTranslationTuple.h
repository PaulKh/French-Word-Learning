//
//  WordTranslationTuple.h
//  WordLearning
//
//  Created by Khvorostov on 17/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Dictionary, Word;

@interface WordTranslationTuple : NSManagedObject

@property (nonatomic, retain) NSString * audioSource;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * numberOfTrainings;
@property (nonatomic, retain) NSString * wordDescription;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSDate * lastTrainingDay;
@property (nonatomic, retain) Dictionary *dictionary;
@property (nonatomic, retain) NSSet *translations;
@property (nonatomic, retain) Word *word;
@end

@interface WordTranslationTuple (CoreDataGeneratedAccessors)

- (void)addTranslationsObject:(Word *)value;
- (void)removeTranslationsObject:(Word *)value;
- (void)addTranslations:(NSSet *)values;
- (void)removeTranslations:(NSSet *)values;

- (NSString *)allTranslationsInASingleString;

@end
