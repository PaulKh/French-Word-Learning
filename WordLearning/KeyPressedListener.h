//
//  KeyPressedListener.h
//  WordLearning
//
//  Created by Khvorostov on 24/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#ifndef WordLearning_KeyPressedListener_h
#define WordLearning_KeyPressedListener_h
#import <Cocoa/Cocoa.h>
@protocol KeyPressedListener <NSObject>

- (void)keyPressed:(NSEvent *)theEvent;

@end
#endif
