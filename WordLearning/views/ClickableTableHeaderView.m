//
//  ClickableTableHeaderView.m
//  WordLearning
//
//  Created by Khvorostov on 20/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import "ClickableTableHeaderView.h"

@implementation ClickableTableHeaderView
-(void)mouseDown:(NSEvent *)theEvent {
    NSInteger clickedColumn = [self columnAtPoint:[self convertPoint:theEvent.locationInWindow fromView:nil]];
//    NSTableColumn *tableColumn = clickedColumn != -1 ? self.tableView.tableColumns[clickedColumn] : nil;
    [self.delegate clickOnTableColumn:(int)clickedColumn];
}

@end
