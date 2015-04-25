//
//  LoginViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MBProgressHUD.h"
#import "unity.h"
#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
{
    MBProgressHUD *HUD;
    AppDelegate*appdelegate;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.view addSubview:HUD];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"offLoginloading" object:nil];
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];

}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"offLoginloading"]) {
        [HUD removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)Login:(id)sender {
    
//    if (self.emailLogin==nil|| [self.emailLogin.text isEqualToString:@""]) {
//        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
//                                                         message:NSLocalizedString(@"please input username",nil)
//                                                        delegate:self
//                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
//                                               otherButtonTitles:nil, nil];
//        [alertTmp show];
//    }
//    else if (self.passLogin.text==nil|| [self.passLogin.text isEqualToString:@""])
//    {
//        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
//                                                         message:NSLocalizedString(@"please input Password",nil)
//                                                        delegate:self
//                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
//                                               otherButtonTitles:nil, nil];
//        [alertTmp show];
//    }
//    else
//    {
//        NSString *deviceType = @"iOS";
//        [HUD show:YES];
//        NSString *deviceToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceToken"];        [unity login_by_email:self.emailLogin.text pass:self.passLogin.text regId:deviceToken deviceType:deviceType  owner:self];
//    }
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)checkLogin
{
    NSUserDefaults *loginInfo = [NSUserDefaults standardUserDefaults];
    appdelegate.yoursefl=(NSMutableDictionary*)self.dataUser;

    NSLog(@"data: %@",self.dataUser);

    NSString * driverid=[self.dataUser objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults] setObject:driverid forKey:@"idDriver"];
    
    [unity getTrip:driverid owner:self];

}
-(void)checkTrip
{
    NSLog(@"datatrip:%@",self.dataTrip);
    appdelegate.tripinfo=self.dataTrip;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)Register:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    RegisterViewController *controller = (RegisterViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"RegisterViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
}
@end
