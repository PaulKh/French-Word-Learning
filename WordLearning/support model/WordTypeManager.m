//
//  WordType.m
//  WordLearning
//
//  Created by Khvorostov on 16/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "WordTypeManager.h"

@implementation WordTypeManager

static WordTypeManager *instance;
NSMutableArray *wordTypes;

+(WordTypeManager *) instance{
    if (instance == nil) {
        instance =  [[self alloc] init];
    }
    return instance;
}
-(id)init{
    self = [super init];
    if (self) {
        NSArray *types = @[@"Verb",@"Noun",@"Adjective",@"Adverb",@"Function word",@"Phrasal verb", @"Not set"];
        wordTypes = [[NSMutableArray alloc] init];
        for (int i = 0; i < types.count - 1; i++) {
            [wordTypes addObject:[[WordType alloc] initWordTypeWithTypeName:types[i] representativeId:i]];
        }
        self.defaultWordType = wordTypes[wordTypes.count - 1];
    }
    return self;
}

-(WordType *)wordTypeById:(int)idRepresentedInDB{
    for (int i = 0; i < wordTypes.count; i++) {
        if (idRepresentedInDB == ((WordType *)wordTypes[i]).number) {
            return ((WordType *)wordTypes[i]);
        }
    }
    return self.defaultWordType;
    
}

-(WordType *)wordTypeByName:(NSString *)name{
    for (int i = 0; i < wordTypes.count; i++) {
        if ([name isEqualToString:((WordType *)wordTypes[i]).name]) {
            return ((WordType *)wordTypes[i]);
        }
    }
    return self.defaultWordType;
}

-(NSArray *)allWordTypes{
    return wordTypes;
}

@end
