//
//  PromotionTripViewController.h
//  TaxiNetDriver
//
//  Created by Louis Nhat on 4/23/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "unity.h"
#import "promotionCell.h"
#import "SKSTableView.h"
@interface PromotionTripViewController : UIViewController<SKSTableViewDelegate>

@property(nonatomic,retain) NSArray *ArrListPromotion;
//@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)AddPromotionTrip:(id)sender;
@property (weak, nonatomic) IBOutlet SKSTableView *Tableview;

@end
