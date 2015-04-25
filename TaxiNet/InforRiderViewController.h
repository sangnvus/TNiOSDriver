//
//  InforRiderViewController.h
//  TaxiNetDriver
//
//  Created by Louis Nhat on 4/25/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JPSThumbnailAnnotation.h"

@interface InforRiderViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
@property (nonatomic,retain) NSDictionary *dataRider;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UILabel *riderName;
@property (weak, nonatomic) IBOutlet UILabel *riderPhone;
@property (weak, nonatomic) IBOutlet UILabel *riderTime;
@property (weak, nonatomic) IBOutlet UILabel *riderFrom;
@property (weak, nonatomic) IBOutlet UILabel *riderTo;
@property (weak, nonatomic) IBOutlet UILabel *riderSheet;
- (IBAction)reject:(id)sender;
- (IBAction)acept:(id)sender;

@end
