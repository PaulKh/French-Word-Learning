//
//  Dictionary.h
//  WordLearning
//
//  Created by Khvorostov on 17/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WordTranslationTuple;

@interface Dictionary : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * avatarSource;
@property (nonatomic, retain) NSSet *wordTranslationTuple;
@end

@interface Dictionary (CoreDataGeneratedAccessors)

- (void)addWordTranslationTupleObject:(WordTranslationTuple *)value;
- (void)removeWordTranslationTupleObject:(WordTranslationTuple *)value;
- (void)addWordTranslationTuple:(NSSet *)values;
- (void)removeWordTranslationTuple:(NSSet *)values;

@end
