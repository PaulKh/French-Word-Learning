//
//  LerningHelper.h
//  WordLearning
//
//  Created by Khvorostov on 17/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordTranslationTuple.h"
@interface LearningHelper : NSObject

@property (strong) NSArray *daysBetweenRepeation;

+(LearningHelper *) instance;
-(BOOL)isWordNeedToBeLearnt:(WordTranslationTuple *)word;
-(void)shuffle:(NSMutableArray *)objects;
-(int)whenToRepeatNextTime:(WordTranslationTuple *)tuple;
@end
