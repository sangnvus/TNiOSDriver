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
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *numberRider;
@property (weak, nonatomic) IBOutlet UILabel *adressTo;
@property (weak, nonatomic) IBOutlet UILabel *adressFrom;
@property (weak, nonatomic) IBOutlet UILabel *timeDate;
-(void)setValueCell:(NSDictionary *)data;

@end
