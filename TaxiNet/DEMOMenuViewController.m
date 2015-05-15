//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "HomeViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "NavigationController.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "CompanyInfoViewController.h"
#import "unity.h"
#import "PromotionTripViewController.h"
#import "CompanyInfoViewController.h"
#import "MyTripViewController.h"
#import "AboutUsViewController.h"
#import "SupportViewController.h"

@interface DEMOMenuViewController (){
    AppDelegate*appDelegate;
    UIImageView *imageView;
    UILabel *label;
    UIStoryboard *mainStoryboard;
    UIStoryboard *otherStoryboard;
    NavigationController *navigationController;
    UIStoryboard *mainStoryboard1;
}

@end

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    mainStoryboard = [UIStoryboard storyboardWithName:@"HomeView" bundle: nil];
    mainStoryboard1 = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    otherStoryboard = [UIStoryboard storyboardWithName:@"Other" bundle:nil];

    navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
    navigationController.viewControllers = @[controller];

    [navigationController setViewControllers:@[controller]];
    
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"driver_icon.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text = @"Driver Application";
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
       
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

  
   
    if (indexPath.row == 0) {
        HomeViewController *controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 1)
    {
        ProfileViewController *controller = (ProfileViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"ProfileViewController"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 2)
    {
        CompanyInfoViewController *controller = (CompanyInfoViewController*)[otherStoryboard instantiateViewControllerWithIdentifier: @"MyTrip"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 3)
    {
       // NSUserDefaults *userDF = [NSUserDefaults standardUserDefaults];
        
      //  [unity getCompanyInfoWithDriderId:[userDF objectForKey:@"idDriver"] owner:self];
        CompanyInfoViewController *controller = (CompanyInfoViewController*)[otherStoryboard instantiateViewControllerWithIdentifier: @"CompanyInfo"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 4){
        PromotionTripViewController *controller = (PromotionTripViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"PromotionTripViewController"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 5){
        SupportViewController *controller = (SupportViewController*)[otherStoryboard instantiateViewControllerWithIdentifier: @"AboutUs"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 6)
    {
        SupportViewController *controller = (SupportViewController*)[otherStoryboard instantiateViewControllerWithIdentifier: @"Support"];
        [navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 7){
        LoginViewController  *controller = (LoginViewController *)[mainStoryboard1 instantiateViewControllerWithIdentifier: @"LoginViewController"];
        [navigationController pushViewController:controller animated:YES];
        NSString* idDriver = [[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"];
                NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
                NSDictionary * dict = [defs dictionaryRepresentation];
                for (id key in dict) {
                    [defs removeObjectForKey:key];
                }
                [defs synchronize];
                NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [unity LogOut:idDriver];
    }
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
        NSArray *titles = @[@"Home", @"Profile", @"My Trips",@"Company info", @"Promotion Trips",@"About US", @"Support",@"Logout"];
        cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}
 
@end
