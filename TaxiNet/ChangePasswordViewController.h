//
//  ChangePasswordViewController.h
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *viewBar;
@property (strong, nonatomic) IBOutlet UIView *viewContent;

@property (strong, nonatomic) IBOutlet UITextField *oldPassword;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;

- (IBAction)doChangePassword:(id)sender;

- (IBAction)backBtn:(id)sender;
-(void)checkResponseMessage:(NSString*)message;
@end
