//
//  ClickableTableHeaderView.h
//  WordLearning
//
//  Created by Khvorostov on 20/03/15.
//  Copyright (c) 2015 Khvorostov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol TableHeaderViewDelegate <NSObject>
-(void)clickOnTableColumn:(int)tableColumn;
@end

@interface ClickableTableHeaderView : NSTableHeaderView

@property (weak) IBOutlet id<TableHeaderViewDelegate> delegate;

@end
