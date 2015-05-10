//
//  MyTripDetailsViewController.m
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/10/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "MyTripDetailsViewController.h"
#import "AppDelegate.h"
#import "MyTripViewController.h"

@interface MyTripDetailsViewController ()

@end

@implementation MyTripDetailsViewController
{
    AppDelegate *appdelegate;
    NSArray *riderInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    riderInfo = [[NSArray alloc]init];
    riderInfo = [appdelegate.myTripInfo valueForKey:@"rider"];
    // show trip details
    self.customerNameLb.text = [NSString stringWithFormat:@"%@ %@",[riderInfo valueForKey:@"firstName"],[riderInfo valueForKey:@"lastName"]];
    self.fromAddressLb.text = [appdelegate.myTripInfo valueForKey:@"fromAddress"];
    self.toAddressLb.text = [appdelegate.myTripInfo valueForKey:@"toAddress"];
    self.distanceLb.text = [NSString stringWithFormat:@"%@ Km",[appdelegate.myTripInfo valueForKey:@"distance"]];
    self.startDateLb.text = [appdelegate.myTripInfo valueForKey:@"startTime"];
    self.endDateLb.text = [appdelegate.myTripInfo valueForKey:@"endTime"];
    self.paymentMethodLb.text = [appdelegate.myTripInfo valueForKey:@"paymentType"];
    self.phoneNumberLb.text = [riderInfo valueForKey:@"phone"];
    self.costLb.text = [NSString stringWithFormat:@"%@",[appdelegate.myTripInfo valueForKey:@"fee"]]; //[appdelegate.myTripInfo valueForKey:@"fee"];

    // set color
    [self.viewBar setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    
    [self.viewContent setBackgroundColor:[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showData:(NSArray*)myTripData{

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)callToCustomer:(id)sender {
    NSString *phoneNo = [@"tel://" stringByAppendingString:[self.phoneNumberLb.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNo]];
}

- (IBAction)backBtn:(id)sender {
    UIStoryboard *otherStory = [UIStoryboard storyboardWithName:@"Other" bundle:nil];
    MyTripViewController *myTrip = (MyTripViewController*)[otherStory instantiateViewControllerWithIdentifier:@"MyTrip"];
    [self.navigationController pushViewController:myTrip animated:YES];
}
@end
