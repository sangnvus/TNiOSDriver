//
//  PromotionTripViewController.m
//  TaxiNetDriver
//
//  Created by Louis Nhat on 4/23/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "PromotionTripViewController.h"
#import "SKSTableViewCell.h"
#import "AddTripViewController.h"
#import "InforRiderViewController.h"
@interface PromotionTripViewController ()

@end

@implementation PromotionTripViewController
{
    NSArray *arr2;
    NSArray *arrSectionName;

}
@synthesize Tableview;
@synthesize ArrListPromotion;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* idDriver = [[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"];
   [unity GetListPromotionTrip:@"1" owner:self];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"NewListPromotin" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"ReloadListTrip" object:nil];

    self.Tableview.SKSTableViewDelegate = self;
    
    [self.Tableview registerNib:[UINib nibWithNibName:@"SKSTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"SKSTableViewCell"];
}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"NewListPromotin"]) {
        NSLog(@"%@",ArrListPromotion);
        [self reloadTableViewWithData:ArrListPromotion];
    }
    if ([[notification name]isEqualToString:@"ReloadListTrip"]) {
        NSString* idDriver = [[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"];
        [unity GetListPromotionTrip:idDriver owner:self];
    }
}
- (void)reloadTableViewWithData:(NSArray *)array
{
    [self.Tableview refreshDataWithScrollingToIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ArrListPromotion count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [[ArrListPromotion[indexPath.row] objectForKey:@"promotionTripRiders"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
//    cell.labrr.text = arrSectionName[indexPath.row];
    
    cell.expandable = YES;
    NSLog(@"data:%ld",(long)indexPath.row );

    NSDictionary *dataRider=[ArrListPromotion objectAtIndex:indexPath.row];
    NSString *numbersubrow=[NSString stringWithFormat:@"%lu",(unsigned long)[[ArrListPromotion[indexPath.row] objectForKey:@"promotionTripRiders"] count]];
    [cell setValueCell:dataRider];
    cell.numberRider.text=numbersubrow;
    if ([[ArrListPromotion[indexPath.row] objectForKey:@"promotionTripRiders"] count]==0)
        cell.expandable = NO;
    else
        cell.expandable = YES;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    NSArray *arrRider=[ArrListPromotion[indexPath.row] objectForKey:@"promotionTripRiders"];
    NSDictionary *riderInfo=[arrRider objectAtIndex:indexPath.subRow-1];
    NSDictionary *riderDetail=[riderInfo objectForKey:@"rider"];
    NSString *name = [NSString stringWithFormat:@"%@ %@", [riderDetail objectForKey:@"firstName"],[riderDetail objectForKey:@"lastName"]];
    UILabel *nameRider = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 30)];
    nameRider.text = name;
    [cell addSubview:nameRider];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
//        NSLog(@"Row:%d, Subrow:%d", indexPath.row, indexPath.subRow);
    NSArray *arrRider=[ArrListPromotion[indexPath.row] objectForKey:@"promotionTripRiders"];
    NSDictionary *riderInfo=[arrRider objectAtIndex:indexPath.subRow-1];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    InforRiderViewController *controller = (InforRiderViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"InforRiderViewController"];
    controller.dataRider=riderInfo;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)AddPromotionTrip:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    AddTripViewController *controller = (AddTripViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"AddTripViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)menu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
@end
