//
//  HomeViewController.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/6/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JPSThumbnailAnnotation.h"
#import "UIViewController+CWPopup.h"
#import "unity.h"
#import "AppDelegate.h"

@interface HomeViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
- (IBAction)menu:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UIView *ViewDetail;

@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (nonatomic,strong) NSArray *nearTaxi;
@property (weak, nonatomic) IBOutlet UIView *maphome;
@property (weak, nonatomic) IBOutlet UILabel *riderName;
@property (weak, nonatomic) IBOutlet UILabel *riderPhone;
@property (weak, nonatomic) IBOutlet UILabel *riderFrom;
@property (weak, nonatomic) IBOutlet UILabel *riderTo;
- (IBAction)Acept:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)show:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UIView *boder0;
@property (weak, nonatomic) IBOutlet UIView *boder1;
@property (weak, nonatomic) IBOutlet UIView *boder2;
@property (weak, nonatomic) IBOutlet UIView *boder3;
@property (weak, nonatomic) IBOutlet UIView *boder4;
@property (weak, nonatomic) IBOutlet UIButton *btnAcept;
@property (nonatomic, assign) NSInteger  pickRider;

- (void)findWay;
-(void)checkGetnearTaxi;
@end
