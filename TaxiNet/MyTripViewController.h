//
//  MyTripViewController.h
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTripViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *viewBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *myTripInfo;

- (IBAction)showMenu:(id)sender;
-(void)checkData;

@end
