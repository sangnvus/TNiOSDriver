//
//  CompanyInfoViewController.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyInfoViewController : UIViewController
- (IBAction)menu:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewBar;
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UIView *viewComName;
@property (strong, nonatomic) IBOutlet UIView *viewAddress;
@property (strong, nonatomic) IBOutlet UIView *viewCity;
@property (strong, nonatomic) IBOutlet UIView *viewPortalCode;
@property (strong, nonatomic) IBOutlet UIView *viewTel;
@property (strong, nonatomic) IBOutlet UIView *viewTax;
@property (strong, nonatomic) IBOutlet UIView *viewCar;

@property (strong, nonatomic) IBOutlet UILabel *comNameLb;
@property (strong, nonatomic) IBOutlet UILabel *addressLb;
@property (strong, nonatomic) IBOutlet UILabel *cityLb;
@property (strong, nonatomic) IBOutlet UILabel *potalCodeLb;
@property (strong, nonatomic) IBOutlet UILabel *telLb;
@property (strong, nonatomic) IBOutlet UILabel *taxLb;
@property (strong, nonatomic) IBOutlet UILabel *carLb;



@end
