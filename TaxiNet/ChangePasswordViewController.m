//
//  ChangePasswordViewController.m
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "unity.h"
#import "LoginViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

@synthesize oldPassword,password,confirmPassword,viewBar,viewContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // set color
    //[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1] /*#feefe7*/
    [viewBar setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    
    
    [viewContent setBackgroundColor:[UIColor colorWithRed:0.996 green:0.937 blue:0.906 alpha:1]];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyBoard{
    [oldPassword resignFirstResponder];
    [password resignFirstResponder];
    [confirmPassword resignFirstResponder];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)checkResponseMessage:(NSString *)message
{
    NSLog(@" message: %@",message);
    if ([message isEqualToString:@"SUCCESS"]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"SUCCESSFUL"
                                                         message:NSLocalizedString(@"Your password has been changed successfully!",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
        
        UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *login = (LoginViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:login animated:YES];
        
    }else if([message isEqualToString:@"FAIL"]){
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"ERROR"
                                                         message:NSLocalizedString(@"Your old password is not correct.",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
      
    }
    
    
}

- (IBAction)doChangePassword:(id)sender {
    
    if ([self.oldPassword.text  isEqual: @""] || [self.oldPassword.text length]==0) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your old password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if([self.password.text  isEqual: @""] || [self.password.text length]==0) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Please enter your new password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else if(password.text.length < 6 || password.text.length >20) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Your password must be 6 - 20 characters.",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }
    else if(![self.password.text isEqualToString:self.confirmPassword.text]) {
        UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                         message:NSLocalizedString(@"Password does not match the confirm password",nil)
                                                        delegate:self
                                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                               otherButtonTitles:nil, nil];
        [alertTmp show];
    }else{
        
        NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
        NSString *driverId = [userDF objectForKey:@"idDriver"];
        [unity changePasswordWithDriverId:driverId oldPassword:oldPassword.text password:password.text owner:self];
        
    }
    
}

- (IBAction)backBtn:(id)sender {
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
    ProfileViewController *controller = (ProfileViewController*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
