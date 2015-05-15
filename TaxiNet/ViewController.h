//
//  ViewController.h
//  TaxiNetDriver
//
//  Created by Louis Nhat on 5/14/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "unity.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
@interface ViewController : UIViewController
@property (weak,nonatomic) NSDictionary *dataAutoLogin;
@property (weak,nonatomic) NSDictionary *dataTrip;

-(void)CheckLogin;
-(void)checkTrip;

@end
