//
//  UserInfo.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/28/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic,copy) NSDictionary *dataUser;
@property (nonatomic,copy) NSDictionary *dataTrip;
@property (nonatomic,copy) NSArray *neartaxi;
@property (nonatomic,copy) NSArray *ArrListPromiton;

@end
