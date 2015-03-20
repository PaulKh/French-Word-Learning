//
//  Word.h
//  WordLearning
//
//  Created by Khvorostov on 18/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WordTranslationTuple;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSNumber * language;
@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) WordTranslationTuple *translations;
@property (nonatomic, retain) WordTranslationTuple *tuple;

@end
