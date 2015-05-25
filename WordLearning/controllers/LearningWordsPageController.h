//
//  LearningWordsPageController.h
//  WordLearning
//
//  Created by Khvorostov on 18/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DismissViewProtocol.h"
#import "KeyPressedListener.h"

@interface LearningWordsPageController : NSPageController<NSPageControllerDelegate,KeyPressedListener>
@property (weak) id<DismissViewProtocol> dismissDelegate;
@end
