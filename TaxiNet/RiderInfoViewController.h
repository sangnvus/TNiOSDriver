//
//  RiderInfoViewController.h
//  TaxiNetDriver
//
//  Created by Louis Nhat on 5/11/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CWPopup.h"

@interface RiderInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
- (IBAction)call:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *from;
@property (weak, nonatomic) IBOutlet UILabel *to;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *seat;
- (IBAction)acept:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reject;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnai;
@property (nonatomic, retain) UIViewController *vcParent;
@property (nonatomic, retain) NSDictionary *riderData;
@property (nonatomic, retain) NSString *promotionTripId;

@end
