//
//  unity.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/22/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#import "HomeViewController.h"
#import "PromotionTripViewController.h"
#import "ProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "DEMOMenuViewController.h"
#import "MyTripViewController.h"
#import "MyTripInfo.h"

@class HomeViewController;
@class PromotionTripViewController;
@interface unity : NSObject

+(void)login_by_email : (NSString*)email pass:(NSString *)pass regId:(NSString*)regId deviceType:(NSString*)deviceType owner:(LoginViewController*)owner;

+(void)updateByDriverById:(NSString*)jsonData owner:(ProfileViewController*)owner;

+(void)getNearTaxi:(NSString*)latitude
     andLongtitude:(NSString*)longtitude owner:(HomeViewController *)owner;

+(void)register_by_email : (NSString*)email password:(NSString *)pass firstname:(NSString *)firstname lastname:(NSString *)lastname phone:(NSString *)phone language:(NSString *)language usergroup:(NSString *)usergroup countrycode:(NSString *)countrycode;
+(void)updateByRiderById : (NSString*)riderId
                firstName:(NSString*)firstName
                 lastName:(NSString*)lastName
                    email:(NSString*)email
                  phoneNo:(NSString*)phoneNo;
+(void)getTrip:(NSString*)DriverID owner:(LoginViewController *)owner;
+(void)updateCurentStatus:(NSString*)base64;
+(void)updateTrip:(NSString*)RequestID userID:(NSString *)userID status:(NSString *)status owner : (HomeViewController *)owner;
+(void)LogOut:(NSString*)driverid;
+(void)CompleteTrip:(NSString*)tripId cost:(NSString *)cost distance:(NSString *)distance;
+(void)GetListPromotionTrip: (NSString *)idDriver owner:(PromotionTripViewController *)owner;
+(void)AddPromotionTrip: (NSString *)base64;
+(void)UpdatePromotionTripDetails: (NSString *)promotionTripId riderId:(NSString *)riderId driverId:(NSString *)driverId status:(NSString *)status;
+(void)changePasswordWithDriverId:(NSString*)driverId
                      oldPassword:(NSString*)oldPassword
                         password:(NSString*)password owner:(ChangePasswordViewController*)owner;
+(void)getCompanyInfoWithDriderId:(NSString*)driverId;
+(void)getMyTripHistoryWithDriverId:(NSString*)driverId onwer:(MyTripViewController*)owner;

@end
