//
//  ViewController.m
//  TaxiNetDriver
//
//  Created by Louis Nhat on 5/14/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    AppDelegate*appdelegate;
}
@synthesize dataAutoLogin;
- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"GetDevideToken" object:nil];

    // Do any additional setup after loading the view.
}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"GetDevideToken"]) {
        [unity AutoLogin:appdelegate.deviceToken owner:self];
//        [unity AutoLogin:@"123" owner:self];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CheckLogin
{
    NSLog(@"auto:%@",dataAutoLogin);
    NSString *idDriver=[dataAutoLogin objectForKey:@"id"];
    if ([idDriver isEqual:[NSNull null]]) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LoginViewController *controller = (LoginViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        appdelegate.yoursefl=(NSMutableDictionary*)dataAutoLogin;
        [[NSUserDefaults standardUserDefaults] setObject:idDriver forKey:@"idDriver"];
        [unity getCompanyInfoWithDriderId:idDriver];
        [unity getTripAuto:idDriver owner:self];
    }
}
-(void)checkTrip
{
    appdelegate.tripinfo=self.dataTrip;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
