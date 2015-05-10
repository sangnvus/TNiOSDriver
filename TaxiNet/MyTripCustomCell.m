//
//  MyTripCustomCell.m
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/10/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "MyTripCustomCell.h"

@implementation MyTripCustomCell

@synthesize dateTimeLb,fromAddressLb,toAddressLb,customerNameLb;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
