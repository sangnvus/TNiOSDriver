//
//  PaymentViewController.h
//  TaxiNetDriver
//
//  Created by Louis Nhat on 4/26/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameRider;
@property (weak, nonatomic) IBOutlet UIButton *phonenumber;
- (IBAction)callPhone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txt_price;
@property (weak, nonatomic) IBOutlet UITextField *txt_distance;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (nonatomic, retain) UIViewController *vcParent;
@property (nonatomic, retain) NSString *phone;

- (IBAction)SentPayment:(id)sender;

@end
