//
//  promotionCell.h
//  TaxiNetDriver
//
//  Created by Louis Nhat on 4/23/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface promotionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DateTime;
@property (weak, nonatomic) IBOutlet UILabel *FromAdress;
@property (weak, nonatomic) IBOutlet UILabel *ToAdress;
@property (weak, nonatomic) IBOutlet UILabel *Status;
@property (weak, nonatomic) IBOutlet UILabel *riderRequest;
@property (nonatomic, retain) NSDictionary *DataInfoTrip;
-(void)setValueForRow:(NSDictionary *)data;

@property (nonatomic, assign, getter = isExpandable) BOOL expandable;
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;
- (void)addIndicatorView;
- (void)removeIndicatorView;
- (BOOL)containsIndicatorView;

- (void)accessoryViewAnimation;
@end
