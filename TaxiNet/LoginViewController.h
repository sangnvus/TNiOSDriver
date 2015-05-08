//
//  LoginViewController.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/4/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
@interface LoginViewController : UIViewController
- (IBAction)Login:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailLogin;
@property (weak, nonatomic) IBOutlet UITextField *passLogin;
@property (weak,nonatomic) NSDictionary *dataUser;
@property (weak,nonatomic) NSDictionary *dataTrip;

-(void)checkLogin;

-(void)checkTrip;
@end
