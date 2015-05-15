//
//  CompanyInfoViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "CompanyInfoViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"

@interface CompanyInfoViewController ()
{
    AppDelegate *appdelegate;
}
@end

@implementation CompanyInfoViewController{
    
}

@synthesize comNameLb,addressLb,cityLb,potalCodeLb,telLb,taxLb,carLb,plateLb;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.viewBar setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    [self.viewContent setBackgroundColor:[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1]];

    appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSArray *vehicleInfo = [appdelegate.yoursefl objectForKey:@"vehicleDTO"];
    NSString *carName = [NSString stringWithFormat:@"%@ %@",[vehicleInfo valueForKey:@"carMaker"],[vehicleInfo valueForKey:@"carTitle"]];
    NSUserDefaults *companyInfo = [NSUserDefaults standardUserDefaults];
    
    comNameLb.text = [companyInfo objectForKey:@"companyName"];
    addressLb.text = [companyInfo objectForKey:@"companyAddress"];
    cityLb.text = [companyInfo objectForKey:@"companyCity"];
    potalCodeLb.text = [companyInfo objectForKey:@"companyPostalCode"];
    telLb.text = [companyInfo objectForKey:@"companyPhone"];
    taxLb.text = [companyInfo objectForKey:@"companyTaxCode"];
    carLb.text = carName;
    plateLb.text = [vehicleInfo valueForKey:@"vehiclePlate"];
    

    
}

-(void)checkResponseData{
    
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

- (IBAction)menu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
@end
