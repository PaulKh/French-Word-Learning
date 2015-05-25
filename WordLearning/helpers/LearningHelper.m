//
//  LerningHelper.m
//  WordLearning
//
//  Created by Khvorostov on 17/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "LearningHelper.h"

@implementation LearningHelper
static LearningHelper *instance;

+(LearningHelper *) instance{
    if (instance == nil) {
        instance =  [[self alloc] init];
    }
    return instance;
}
-(id)init{
    self = [super init];
    if(self){
        self.daysBetweenRepeation = @[@1, @1, @2, @3, @7, @14, @30, @90, @210];
    }
    return self;
}
-(BOOL)isWordNeedToBeLearnt:(WordTranslationTuple *)word{
    int daysToAdd = [(NSNumber *)self.daysBetweenRepeation[[word.numberOfTrainings intValue]] intValue];
    NSDate *date = [word.lastTrainingDay dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSComparisonResult result = [date compare:[NSDate date]];
    if(result == NSOrderedDescending){
        return NO;
    }
    else return YES;
}
- (void)shuffle:(NSMutableArray *)objects
{
    int count = (int)[objects count];
    for (uint i = 0; i < count; ++i)
    {
        int nElements = count - i;
        int n = arc4random_uniform(nElements) + i;
        [objects exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}
-(int)whenToRepeatNextTime:(WordTranslationTuple *)tuple{
    int daysToAdd = [(NSNumber *)self.daysBetweenRepeation[[tuple.numberOfTrainings intValue]] intValue];
    NSDate *date = [tuple.lastTrainingDay dateByAddingTimeInterval:60*60*24*daysToAdd];
    NSTimeInterval secondsBetween = [date timeIntervalSinceDate:[NSDate date]];
    
    int numberOfHours = secondsBetween / 3600;
    return numberOfHours;
}
@end
