//
//  RootViewPage.m
//  WordLearning
//
//  Created by Khvorostov on 24/05/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "RootViewPage.h"

@implementation RootViewPage

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (BOOL) acceptsFirstResponder
{
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent {
    if (self.keyPressedListener != nil) {
        [self.keyPressedListener keyPressed:theEvent];
    }
}
@end
