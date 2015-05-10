//
//  SupportViewController.h
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SupportViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;
- (IBAction)callSupport:(id)sender;

- (IBAction)sendEmailSupport:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *subjectField;
@property (strong, nonatomic) IBOutlet UITextView *contentField;
- (IBAction)showMenu:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewBar;
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UIView *viewEmailUs;

@end
