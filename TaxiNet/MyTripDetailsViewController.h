//
//  MyTripDetailsViewController.h
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/10/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTripDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *viewBar;
@property (strong, nonatomic) IBOutlet UIView *viewContent;

@property (strong, nonatomic) IBOutlet UILabel *customerNameLb;
@property (strong, nonatomic) IBOutlet UILabel *fromAddressLb;
@property (strong, nonatomic) IBOutlet UILabel *toAddressLb;
@property (strong, nonatomic) IBOutlet UILabel *distanceLb;
@property (strong, nonatomic) IBOutlet UILabel *startDateLb;
@property (strong, nonatomic) IBOutlet UILabel *endDateLb;
@property (strong, nonatomic) IBOutlet UILabel *paymentMethodLb;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberLb;
@property (strong, nonatomic) IBOutlet UILabel *costLb;

- (IBAction)callToCustomer:(id)sender;
- (IBAction)backBtn:(id)sender;
-(void)showData:(NSArray*)myTripData;


@end
