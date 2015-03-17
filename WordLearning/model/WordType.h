//
//  WordType.h
//  WordLearning
//
//  Created by Khvorostov on 17/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordType : NSObject

@property (strong) NSString * name;
@property int number;

-(id)initWordTypeWithTypeName:(NSString *)name representativeId:(int)typeID;

@end
