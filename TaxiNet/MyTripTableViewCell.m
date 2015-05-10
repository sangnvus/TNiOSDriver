//
//  MyTripTableViewCell.m
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/10/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "MyTripTableViewCell.h"

@implementation MyTripTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.viewDateTime setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    
    [self.viewFrom setBackgroundColor:[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
