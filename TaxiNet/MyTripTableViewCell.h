//
//  MyTripTableViewCell.h
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/10/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTripTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dateTimeLb;
@property (strong, nonatomic) IBOutlet UILabel *customerName;
@property (strong, nonatomic) IBOutlet UILabel *fromAddressLb;
@property (strong, nonatomic) IBOutlet UILabel *toAddressLb;

@property (strong, nonatomic) IBOutlet UIView *viewDateTime;
@property (strong, nonatomic) IBOutlet UIView *viewFrom;
@property (strong, nonatomic) IBOutlet UIView *viewCustomer;
@property (strong, nonatomic) IBOutlet UIView *viewTo;


@end
