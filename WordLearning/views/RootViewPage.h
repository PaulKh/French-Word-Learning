//
//  RootViewPage.h
//  WordLearning
//
//  Created by Khvorostov on 24/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KeyPressedListener.h"

@interface RootViewPage : NSView
@property (weak) id<KeyPressedListener> keyPressedListener;
@end
