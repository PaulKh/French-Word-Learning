//
//  WordType.h
//  WordLearning
//
//  Created by Khvorostov on 16/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordType.h"

@interface WordTypeManager : NSObject
-(WordType *)wordTypeById:(int)idRepresentedInDB;
-(WordType *)wordTypeByName:(NSString *)name;
-(NSArray *)allWordTypes;
-(NSArray *)allWordTypesTitles;
+(WordTypeManager *)instance;

@property (strong) WordType *defaultWordType;
@property (strong) NSMutableArray *wordTypes;
@property (strong) NSArray *types;
@end
