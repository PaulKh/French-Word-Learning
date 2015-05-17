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

+(WordTypeManager *) instance{
    if (instance == nil) {
        instance =  [[self alloc] init];
    }
    return instance;
}
-(id)init{
    self = [super init];
    if (self) {
        self.types = @[@"Not set", @"Verb",@"Noun",@"Adjective",@"Adverb",@"Function word",@"Phrasal verb", @"Phrase",@"Rule"];
        self.wordTypes = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.types.count; i++) {
            WordType *wordType = [[WordType alloc] initWordTypeWithTypeName:self.types[i] representativeId:i];
            [self.wordTypes addObject:wordType];
        }
        self.defaultWordType = self.wordTypes[self.wordTypes.count - 1];
    }
    return self;
}

-(WordType *)wordTypeById:(int)idRepresentedInDB{
    for (int i = 0; i < self.wordTypes.count; i++) {
        if (idRepresentedInDB == ((WordType *)self.wordTypes[i]).number) {
            return ((WordType *)self.wordTypes[i]);
        }
    }
    return self.defaultWordType;
    
}

-(WordType *)wordTypeByName:(NSString *)name{
    for (int i = 0; i < self.wordTypes.count; i++) {
        if ([name isEqualToString:((WordType *)self.wordTypes[i]).name]) {
            return ((WordType *)self.wordTypes[i]);
        }
    }
    return self.defaultWordType;
}

-(NSArray *)allWordTypes{
    return self.wordTypes;
}
-(NSArray *)allWordTypesTitles{
    return self.types;
}
@end
