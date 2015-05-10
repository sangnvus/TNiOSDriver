//
//  MyTripViewController.m
//  TaxiNetDriver
//
//  Created by Nguyen Hoai Nam on 5/9/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "MyTripViewController.h"
#import "REFrostedViewController.h"
#import "unity.h"
#import "MyTripTableViewCell.h"
#import "MyTripDetailsViewController.h"

@interface MyTripViewController ()

@end

@implementation MyTripViewController{
    //AppDelegate *appDelegate;
    AppDelegate *appdelege;
    NSArray *myTripArray;
    NSArray *riderInfo;
    
}

@synthesize myTripInfo;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appdelege = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [self.viewBar setBackgroundColor:[UIColor colorWithRed:1 green:0.251 blue:0 alpha:1]];
    [unity getMyTripHistoryWithDriverId:[user objectForKey:@"idDriver"] onwer:self];

    myTripArray = [[NSArray alloc]init];
    riderInfo = [[NSArray alloc] init];
    //NSLog(@"appdelegate data:%@",appDelegate.myTripInfo);
    NSLog(@"MY trip InFO %@",myTripInfo);
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
-(void)checkData{

    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myTripInfo count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myTripArray = [self.myTripInfo objectAtIndex:indexPath.row];
    riderInfo = [myTripArray valueForKey:@"rider"];
    static NSString *simpleTableIdentifier = @"MyTripTableViewCell";
    
    MyTripTableViewCell *cell = (MyTripTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyTripTableViewCell"
                                                     owner:(self)
                                                   options:nil];
        cell = [nib objectAtIndex:0];
    }
    

    cell.dateTimeLb.text = [myTripArray valueForKey:@"startTime"];
    
    cell.fromAddressLb.text = [myTripArray valueForKey:@"fromAddress"];
    cell.toAddressLb.text = [myTripArray valueForKey:@"toAddress"];
    cell.customerName.text = [NSString stringWithFormat:@"%@ %@",[riderInfo valueForKey:@"firstName"],[riderInfo valueForKey:@"lastName"]];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    //[self.tableView removeObjectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTripDetailsViewController *tripDetails;
    myTripArray = [self.myTripInfo objectAtIndex:indexPath.row];
    appdelege.myTripInfo = (NSMutableArray*)myTripArray;
    NSLog(@"DELEGATE TRIP:  %@",appdelege.myTripInfo);
    [tripDetails showData:appdelege.myTripInfo];
    
    if (!([myTripArray count]==0)) {
        UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Other" bundle:nil];
        MyTripDetailsViewController *controller = (MyTripDetailsViewController*)[homeStoryBoard instantiateViewControllerWithIdentifier:@"MyTripDetails"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
    
}


- (IBAction)showMenu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
@end
