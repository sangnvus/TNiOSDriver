//
//  unity.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/22/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//
/*
 NSArray *myArray = [[data objectForKey:@"fromAddress"] componentsSeparatedByString:@","];
 NSMutableArray *mutableArray = [NSMutableArray array];
 [mutableArray addObject:myArray];
 */

#import "unity.h"
// 112.78.6.241

#define URL @"http://callingme.info/taxinet"
#define URL_SIGNIN @"/restServices/DriverController/LoginiOS"
#define UPDATE_URL @"/restServices/DriverController/UpdateDriveriOS"
#define CHANGE_PASSWORD @"/restServices/DriverController/ChangePasswordiOS"
#define NEAR_TAXI_URL @"/restServices/DriverController/getNearDriver"
#define FIND_PROMOTION_TRIP_URL @"/restServices/PromotionTripController/FindPromotionTip"
#define GETTRIP @"/restServices/TripController/GetRequestForDriveriOS"
#define UPDATECURRENT @"/restServices/DriverController/UpdateCurrentStatusiOS"
#define UPDATETRIP @"/restServices/TripController/UpdateTripiOS"
#define LOGOUT @"/restServices/DriverController/Logout"
#define COMPLETETRIP @"/restServices/TripController/CompleteTripiOS"
#define LISTPROMOTIONTRIP @"/restServices/PromotionTripController/GetListPromotionTripiOS"
#define ADDPROMOTIONTRIP @"/restServices/PromotionTripController/AddPromotionTripiOS"
#define UPDATEPROMOTIONTRIP @"/restServices/PromotionTripController/UpdatePromotionTripDetailsiOS"
#define GET_COMPANY_INFO @"/restServices/CompanyController/findCompanyByDriverId"
#define GET_MYTRIP @"/restServices/TripController/GetListCompleteTripiOS"


#define URL_UPLOADPHOTO @"/TN/restServices/PromotionTripController/UpdatePromotionTripDetailsiOS"

@implementation unity
+(void)uploadPhoto:(UIImage *)image imageName:(NSString *)imageName  token:(NSString *)token userID:(NSString*)userid{
    //data
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,URL_UPLOADPHOTO];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSDictionary *parameters = @{@"_user_id":userid,@"_token":token};
    
    //init
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //show progress
    AFHTTPRequestOperation *postRequest = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:imageName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"offloading" object:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"offloading" object:self];
    }];
    [postRequest start];
}
+(void)UpdatePromotionTripDetails: (NSString *)promotionTripId riderId:(NSString *)riderId driverId:(NSString *)driverId status:(NSString *)status
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,UPDATEPROMOTIONTRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"promotionTripId":promotionTripId,@"riderId":riderId,@"driverId":driverId,@"status":status};
    
    [manager POST:url parameters:params2
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"update UPDATEPROMOTIONTRIP success");
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"update UPDATEPROMOTIONTRIP  failse");
     }];
}
+(void)GetListPromotionTrip: (NSString *)idDriver owner:(PromotionTripViewController *)owner
{
    UserInfo *mode=[[UserInfo alloc]init];
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,LISTPROMOTIONTRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"id":idDriver};
    
    [manager POST:url parameters:params2
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"get LISTPROMOTIONTRIP success");
         mode.ArrListPromiton=(NSArray *)responseObject;
         owner.ArrListPromotion=mode.ArrListPromiton;
         [[NSNotificationCenter defaultCenter] postNotificationName:@"NewListPromotin" object:self];
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"get LISTPROMOTIONTRIP failse");
     }];
}
+(void)login_by_email : (NSString*)email pass:(NSString *)pass regId:(NSString*)regId deviceType:(NSString*)deviceType owner:(LoginViewController*)owner
{
    UserInfo *model = [[UserInfo alloc] init];
    if ([regId isEqualToString:@""] || [regId length] == 0) {
        regId = @"123";
    }
    
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,URL_SIGNIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"username":email, @"password":pass,@"regId":regId, @"deviceType":deviceType};
    
    [manager POST:url parameters:params2
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         model.dataUser=[NSDictionary dictionaryWithDictionary:responseObject];
         owner.dataUser=model.dataUser;
         [owner checkLogin];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];


     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                          message:NSLocalizedString(@"please check internet connection login",nil)
                                                         delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                otherButtonTitles:nil, nil];
         [alertTmp show];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];

     }];
}


+(void)updateByDriverById:(NSString *)jsonData owner:(ProfileViewController *)owner
{
    NSString *url=[NSString stringWithFormat:@"%@%@",URL,UPDATE_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"json":jsonData};
    [manager POST:url
       parameters:params2  success:^(AFHTTPRequestOperation *operation, id responseObject) {
           [owner checkDataResponse:[responseObject objectForKey:@"message"]];
           
       }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"ERROR UPDATE: %@",error);
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"LỖI"
                                                               message:NSLocalizedString(@"Cap nhat du lieu khong thanh cong ",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"Đồng ý",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              
          }];
    
    
}


+(void)findPromotionTrips:(NSString *)formLatitude
         andfromLongitude:(NSString *)fromLongitude
           withToLatitude:(NSString *)toLatitude
           andToLongitude:(NSString *)toLongitude
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,FIND_PROMOTION_TRIP_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @ {@"fromLatitude":fromLongitude, @"fromLongitude":fromLongitude, @"toLatitude":toLatitude, @"toLongitude":toLongitude};
    [manager POST:url parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"get FIND_PROMOTION_TRIP_URL success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"get FIND_PROMOTION_TRIP_URL failse");

          }];
}
+(void)getTrip:(NSString*)DriverID owner:(LoginViewController *)owner
{
    UserInfo *model = [[UserInfo alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,GETTRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSDictionary *param = @ {@"driverId":DriverID};

    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"get GETTRIP success");
              model.dataTrip=[NSDictionary dictionaryWithDictionary:responseObject];
              owner.dataTrip=model.dataTrip;
              [owner checkTrip];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
              NSLog(@"get GETTRIP failse");
          }];
}
+(void)updateCurentStatus:(NSString*)base64
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,UPDATECURRENT];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"json":base64};
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@" UPDATECURRENT success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@" UPDATECURRENT failse");

          }];
}
+(void)updateTrip:(NSString*)RequestID userID:(NSString *)userID status:(NSString *)status owner : (HomeViewController *)owner
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,UPDATETRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"requestId":RequestID,@"userId":userID,@"status":status};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([status isEqualToString:@"PI"]) {
                  owner.pickRider=1;
              }
              if ([status isEqualToString:@"PD"]) {
                  owner.pickRider=2;
              }
              NSLog(@"UPDATETRIP success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"UPDATETRIP failse");
              
          }];
}
+(void)LogOut:(NSString*)driverid
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,LOGOUT];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"id":driverid};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"failse");
              
          }];
}
+(void)CompleteTrip:(NSString*)tripId cost:(NSString *)cost distance:(NSString *)distance
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,COMPLETETRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"tripId":tripId,@"cost":cost,@"distance":distance};
    
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"COMPLETETRIP success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"COMPLETETRIP failse");
              
          }];
}
+(void)AddPromotionTrip: (NSString *)base64
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,ADDPROMOTIONTRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"json":base64};
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"ADDPROMOTIONTRIP success");
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"ADDPROMOTIONTRIP failse");
              
          }];
}
+(void)changePasswordWithDriverId:(NSString *)driverId
                      oldPassword:(NSString *)oldPassword
                         password:(NSString *)password
                            owner:(ChangePasswordViewController *)owner
{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL,CHANGE_PASSWORD];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"id":driverId,@"oldpassword":oldPassword,@"newpassword":password};
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              [owner checkResponseMessage:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]]];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                               message:NSLocalizedString(@"please check your internet connection",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];

              
          }];
    
}
+(void)getCompanyInfoWithDriderId:(NSString *)driverId
{
    
    NSString *url=[NSString stringWithFormat:@"%@%@?id=%@",URL,GET_COMPANY_INFO,driverId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   // NSDictionary *params = @ {@"id":driverId};
    
    [manager GET:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"SUCCESS:%@",responseObject);
         NSUserDefaults *companyInfo = [NSUserDefaults standardUserDefaults];
         [companyInfo setObject:[responseObject objectForKey:@"name"] forKey:@"companyName"];
         [companyInfo setObject:[responseObject objectForKey:@"address"] forKey:@"companyAddress"];
         [companyInfo setObject:[responseObject objectForKey:@"city"] forKey:@"companyCity"];
         [companyInfo setObject:[responseObject objectForKey:@"postalCode"] forKey:@"companyPostalCode"];
         [companyInfo setObject:[responseObject objectForKey:@"phone"] forKey:@"companyPhone"];
         [companyInfo setObject:[responseObject objectForKey:@"vatNumber"] forKey:@"companyTaxCode"];
         [companyInfo setObject:[responseObject objectForKey:@"companyID"] forKey:@"companyId"];


     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                          message:NSLocalizedString(@"Please check your internet connection",nil)
                                                         delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                otherButtonTitles:nil, nil];
         [alertTmp show];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
         
     }];
    
}

+(void)getMyTripHistoryWithDriverId:(NSString *)driverId onwer:(MyTripViewController *)owner
{
    MyTripInfo *myTrip = [[MyTripInfo alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@%@?id=%@",URL,GET_MYTRIP,driverId];
    NSLog(@"URL my trips:%@",url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //NSDictionary *param = @{@"id":driverId,@"oldpassword":oldPassword,@"newpassword":password};
    [manager GET:url
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              myTrip.myTripList = [NSArray arrayWithArray:responseObject];
              owner.myTripInfo = myTrip.myTripList;
              [owner checkData];
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                               message:NSLocalizedString(@"Please check your internet connection",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
              
              
          }];
    
}


@end
