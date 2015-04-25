//
//  SKSTableViewCell.h
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SKSTableViewCell : UITableViewCell
@property (nonatomic, assign, getter = isExpandable) BOOL expandable;
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;
- (void)addIndicatorView;
- (void)removeIndicatorView;
- (BOOL)containsIndicatorView;

- (void)accessoryViewAnimation;
@property (weak, nonatomic) IBOutlet UILabel *titlelabe;

@end
