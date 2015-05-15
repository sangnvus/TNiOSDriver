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
#import "REFrostedViewController.h"
#import "UIViewController+CWPopup.h"

@interface PromotionTripViewController : UIViewController<SKSTableViewDelegate>

@property(nonatomic,retain) NSMutableArray *ArrListPromotion;
//@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)AddPromotionTrip:(id)sender;
@property (weak, nonatomic) IBOutlet SKSTableView *Tableview;
- (IBAction)menu:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *GrayView;

@end
