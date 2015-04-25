//
//  InforRiderViewController.m
//  TaxiNetDriver
//
//  Created by Louis Nhat on 4/25/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "InforRiderViewController.h"

@interface InforRiderViewController ()

@end

@implementation InforRiderViewController
@synthesize dataRider;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"da:%@",dataRider);
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

- (IBAction)reject:(id)sender {
}

- (IBAction)acept:(id)sender {
}
@end
