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
    
    self.Tableview.SKSTableViewDelegate = self;
    NSDictionary *params5 = @ {};
    NSDictionary *params1 = @ {@"username":@"111aaa",@"numberSubcell":params5, @"password":@"abc",@"regId":@"123", @"deviceType":@"456"};
    NSDictionary *params2 = @ {@"username":@"aaa",@"numberSubcell":params5, @"password":@"abc",@"regId":@"123", @"deviceType":@"456"};
    NSDictionary *params4 = @ {@"username":@"xzxzxzxzx",@"numberSubcell":@"", @"password":@"abc",@"regId":@"123", @"deviceType":@"456"};
    NSArray *arr=@[params1,params4];
    NSDictionary *params3 = @ {@"username":@"111aaa",@"numberSubcell":arr, @"password":@"abc",@"regId":@"123", @"deviceType":@"456"};
    arr2=@[params1,params2,params3];
    arrSectionName = @[@"param1",@"param2",@"param3"];

}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"NewListPromotin"]) {
        NSLog(@"%@",ArrListPromotion);
        [self.Tableview reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr2 count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return [[arr2[indexPath.row] objectForKey:@"numberSubcell"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (!cell)
//        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SKSTableViewCell" owner:self options:nil];
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.titlelabe.text = arrSectionName[indexPath.row];
    
    cell.expandable = YES;
    
    if ([[arr2[indexPath.row] objectForKey:@"numberSubcell"] count]==0)
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[arr2[indexPath.row] allValues] objectAtIndex:indexPath.subRow - 1]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
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
@end
