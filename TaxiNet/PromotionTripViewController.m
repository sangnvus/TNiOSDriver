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
#import "RiderInfoViewController.h"
@interface PromotionTripViewController ()

@end

@implementation PromotionTripViewController
{
    NSArray *arr2;
    NSArray *arrSectionName;
    UITapGestureRecognizer *gestureGray;

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
//    self.Tableview.allowsMultipleSelectionDuringEditing = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"hidenGrayView" object:nil];
    gestureGray = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(dismissDetail:)];
    [self.GrayView addGestureRecognizer:gestureGray];
}

-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"hidenGrayView"]) {
        self.GrayView.hidden=YES;
    }
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
    
//    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    NSArray *arrRider=[ArrListPromotion[indexPath.row] objectForKey:@"promotionTripRiders"];
    NSDictionary *riderInfo=[arrRider objectAtIndex:indexPath.subRow-1];
    NSDictionary *riderDetail=[riderInfo objectForKey:@"rider"];
    NSString *status=[riderInfo objectForKey:@"status"];
    NSString *name = [NSString stringWithFormat:@"%@ %@", [riderDetail objectForKey:@"firstName"],[riderDetail objectForKey:@"lastName"]];
    UILabel *nameRider = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 30)];
    nameRider.text = name;
    [nameRider setTextColor:[UIColor colorWithRed:27.0f/255.0f
                                            green:159.0f/255.0f
                                             blue:252.0f/255.0f
                                            alpha:1.0f]];
    [cell addSubview:nameRider];
    
    UILabel *statusRider = [[UILabel alloc]initWithFrame:CGRectMake(220, 12, 100, 15)];
    if ([status isEqualToString:@"NR"]) {
        statusRider.text = @"New reqest";
    }
    else if ([status isEqualToString:@"AC"])
    {
        statusRider.text = @"Acepted";
    }
    else if([status isEqualToString:@"RJ"])
        statusRider.text = @"Rejected";
    else
        statusRider.text = @"Request";

    [statusRider setTextColor:[UIColor redColor]];
    [cell addSubview:statusRider];
    
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
    NSDictionary *dataCell=[ArrListPromotion objectAtIndex:indexPath.row];
    NSArray *arrRider=[ArrListPromotion[indexPath.row] objectForKey:@"promotionTripRiders"];
    NSDictionary *riderInfo=[arrRider objectAtIndex:indexPath.subRow-1];
    
    RiderInfoViewController *detail = [[RiderInfoViewController alloc] initWithNibName:@"RiderInfoViewController" bundle:nil];
    detail.vcParent = self;
    detail.riderData=riderInfo;
    detail.promotionTripId=[dataCell objectForKey:@"id"];
    [self presentPopupViewController:detail animated:YES completion:^(void) {
        NSLog(@"popup view presented");
    }];
    self.GrayView.hidden=NO;

}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //add code here for when you hit delete
//        [ArrListPromotion removeObjectAtIndex:indexPath.row];
//        [self reloadTableViewWithData:ArrListPromotion];
//    }
//}
-(void)dismissDetail:(UITapGestureRecognizer *)recognizer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissDetail" object:self];
    
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
