//
//  WordType.m
//  WordLearning
//
//  Created by Khvorostov on 17/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "WordType.h"

@implementation WordType

-(id)initWordTypeWithTypeName:(NSString *)name representativeId:(int)typeID{
    if (self = [super init]) {
        self.name = name;
        self.number = typeID;
    }
    return self;
}
@end
