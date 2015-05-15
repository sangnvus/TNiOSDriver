//
//  RiderInfoViewController.m
//  TaxiNetDriver
//
//  Created by Louis Nhat on 5/11/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "RiderInfoViewController.h"
#import "unity.h"
@interface RiderInfoViewController ()

@end

@implementation RiderInfoViewController
{
    NSString* idDriver,*riderId;
}
@synthesize riderData,promotionTripId;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"dismissDetail" object:nil];
    idDriver = [[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"];
    
    NSDictionary *riderInfo=[riderData objectForKey:@"rider"];

    NSString *name=[riderInfo objectForKey:@"lastName"];
    NSString *phone=[riderInfo objectForKey:@"phone"];
    NSString *fromAddress=[riderData objectForKey:@"fromAddress"];
    NSString *toAddress=[riderData objectForKey:@"toAddress"];
    int numberOfSeats=[[riderData objectForKey:@"numberOfSeats"] intValue];
    NSString *timeStart=[NSString stringWithFormat:@"%@",[riderData objectForKey:@"timeStart"]];
    riderId =[riderInfo objectForKey:@"riderId"];
    self.name.text=name;
    self.phone.text=phone;
    self.from.text=fromAddress;
    self.to.text=toAddress;
    self.seat.text=[NSString stringWithFormat:@"%i",numberOfSeats];
    self.time.text=timeStart;


}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"dismissDetail"]) {
        [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hidenGrayView" object:self];
            
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)call:(id)sender {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:[self.phone.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
- (IBAction)acept:(id)sender {
    [unity UpdatePromotionTripDetails:promotionTripId riderId:riderId driverId:idDriver status:@"AC"];
    [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hidenGrayView" object:self];

    }];
}
- (IBAction)Reject:(id)sender {
    [unity UpdatePromotionTripDetails:promotionTripId riderId:riderId driverId:idDriver status:@"RJ"];
    [self.vcParent dismissPopupViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hidenGrayView" object:self];
        
    }];
}
@end
