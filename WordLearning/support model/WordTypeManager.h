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

@property (strong) WordType *defaultWordType;
@end
