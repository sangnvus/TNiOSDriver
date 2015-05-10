//
//  HomeViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/6/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "REFrostedViewController.h"
#import "PaymentViewController.h"
@interface HomeViewController () {
    CLLocationCoordinate2D coordinateFrom;
    CLLocationCoordinate2D coordinateTo;

    CLLocationCoordinate2D coordinate;
    MKPlacemark *placeFrom, *placeTo;
    int locationStatus;
    UITapGestureRecognizer *gestureFrom, *gestureTo;
    MKRoute *routeDetails;
    NSInteger selectTo;
    BOOL fromselect;
    NSDictionary *TripDetail;

}



@end

@implementation HomeViewController
{
    AppDelegate*appdelegate;
}

@synthesize mapview;
@synthesize pickRider;
- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    fromselect=FALSE;
    locationStatus=0;
    pickRider=0;
    //set anchor point focus point
    mapview.delegate = self;
    // Map View
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:1];

    selectTo=0;
    self.thumbnail.layer.masksToBounds = YES;
    self.thumbnail.layer.cornerRadius = self.thumbnail.frame.size.height/2;
    NSString *longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    NSString *latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    JPSThumbnail *annotationTo = [[JPSThumbnail alloc] init];
    annotationTo.coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
    annotationTo.image = [UIImage imageNamed:@"fromMap.png"];
    [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotationTo]];
    [self.boder0 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    [self.boder1 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    [self.boder2 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    [self.boder3 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    [self.boder4 setBackgroundColor: [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"getRiderInfo" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"updatecurrentStatus" object:nil];
    TripDetail=[[NSDictionary alloc]init];
    self.ViewDetail.hidden=YES;
    if (appdelegate.tripinfo.count != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:[appdelegate.tripinfo objectForKey:@"id"] forKey:@"requestID"];
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"APNS" message:@"You have request" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        TripDetail =appdelegate.tripinfo;
        [self showTrip];
        [UIView beginAnimations:@"animateAddContentView" context:nil];
        [UIView setAnimationDuration:0.4];
        [self showDetailRider];
        [UIView commitAnimations];
        locationStatus=1;
        self.ViewDetail.hidden=NO;
    }

}
-(void) receiveNotification:(NSNotification *) notification
{
    if ([[notification name]isEqualToString:@"getRiderInfo"]) {
        if (appdelegate.RiderInfo.count != 0) {
            [UIView beginAnimations:@"animateAddContentView" context:nil];
            [UIView setAnimationDuration:0.4];
            [self showDetailRider];
            [UIView commitAnimations];
            
            NSDictionary *data=appdelegate.RiderInfo;
            NSString *name=[data objectForKey:@"name"];
            NSString *phone=[data objectForKey:@"phone"];
            NSString *adressFrom=[data objectForKey:@"fromAddress"];
            NSString *adressTo=[data objectForKey:@"toAddress"];
            self.riderName.text=name;
            self.riderPhone.text=phone;
            self.riderFrom.text=adressFrom;
            self.riderTo.text=adressTo;
            [[NSUserDefaults standardUserDefaults] setObject:[data objectForKey:@"id"] forKey:@"requestID"];
            
            
            NSString *latitu=[data objectForKey:@"startLatitude"];
            NSString *lontitu=[data objectForKey:@"startLongitude"];
            coordinateTo.latitude=[latitu doubleValue];
            coordinateTo.longitude=[lontitu doubleValue];
            placeFrom = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([latitu doubleValue], [lontitu doubleValue]) addressDictionary:nil];
            
            NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
            NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
            coordinateFrom.latitude=[latitude doubleValue];
            coordinateFrom.longitude=[longitude doubleValue];
            placeTo = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]) addressDictionary:nil];
            [self findWay];
            
            JPSThumbnail *empire = [[JPSThumbnail alloc] init];
            empire.image = [UIImage imageNamed:@"toMap"];
            empire.coordinate = CLLocationCoordinate2DMake([latitu floatValue], [lontitu floatValue]);
            [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:empire]];
            self.ViewDetail.hidden=NO;
        }
    }
    if ([[notification name]isEqualToString:@"updatecurrentStatus"]) {
//        [self updateCurrentStatus];
    }
}
-(void)showTrip
{
    NSDictionary *rider=[TripDetail objectForKey:@"rider"];
    NSString *name=[NSString stringWithFormat:@"%@ %@",[rider objectForKey:@"firstName"],[rider objectForKey:@"lastName"]];
    NSString *phone=[rider objectForKey:@"phone"];
    NSString *adressFrom=[TripDetail objectForKey:@"fromAddress"];
    NSString *adressTo=[TripDetail objectForKey:@"toAddress"];
    self.riderName.text=name;
    self.riderPhone.text=phone;
    self.riderFrom.text=adressFrom;
    self.riderTo.text=adressTo;
    
    NSString *latitu=[TripDetail objectForKey:@"startLatitude"];
    NSString *lontitu=[TripDetail objectForKey:@"startLongitude"];
    coordinateTo.latitude=[latitu doubleValue];
    coordinateTo.longitude=[lontitu doubleValue];
    placeFrom = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([latitu doubleValue], [lontitu doubleValue]) addressDictionary:nil];
    JPSThumbnail *empire = [[JPSThumbnail alloc] init];
    empire.image = [UIImage imageNamed:@"toMap"];
    empire.coordinate = CLLocationCoordinate2DMake([latitu floatValue], [lontitu floatValue]);
    [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:empire]];
    
    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    coordinateFrom.latitude=[latitude doubleValue];
    coordinateFrom.longitude=[longitude doubleValue];
    placeTo = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]) addressDictionary:nil];
    [self findWay];
}
-(void)updateCurrentStatus
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"]!=NULL) {
        NSString* longitudeCurrent = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
        NSString* latitudeCurrent = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
        NSString* idDriver = [[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"];
        
        coordinate.latitude =[latitudeCurrent doubleValue];
        coordinate.longitude = [longitudeCurrent doubleValue];
        locationStatus=0;
        [self getReverseGeocode:coordinate];
        NSString* location = [[NSUserDefaults standardUserDefaults] stringForKey:@"adressDriver"];
 

        NSString *data = [NSString stringWithFormat:@"{\"location\":\"%@\",\"longitude\":\"%@\",\"latitude\":\"%@\",\"driverId\":\"%@\"}",location,longitudeCurrent,latitudeCurrent,idDriver];
        
        
        NSData *plainData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64String = [plainData base64EncodedStringWithOptions:0];
        [unity updateCurentStatus:base64String];
        if (location !=nil) {
//            [unity updateCurentStatus:adress andLongtitude:longitudeCurrent latitude:latitudeCurrent driverId:idDriver];
        }
    }

}
-(void)zoomInToMyLocation
{
    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [latitude floatValue] ;
    region.center.longitude = [longitude floatValue];
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [self.mapview setRegion:region animated:YES];
}
-(void)showDetailRider
{
    CGRect fram=self.maphome.frame;
    fram.size.height=390;
    self.maphome.frame=fram;
    CGRect frammap=self.mapview.frame;
    frammap.size.height=390;
    self.mapview.frame=frammap;
    CGRect framrider=self.ViewDetail.frame;
    framrider.origin.y=418;
    self.ViewDetail.frame=framrider;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (IBAction)Acept:(id)sender {
    NSString* requestid = [[NSUserDefaults standardUserDefaults] stringForKey:@"requestID"];
    NSString* idDriver = [[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"];
    NSLog(@"request id : %@ driver id : %@",requestid,idDriver);
    if (pickRider==0) {
        //acept
        [unity updateTrip:requestid userID:idDriver status:@"PI" owner:self];
        [self.btnAcept setTitle:@"Picked" forState:UIControlStateNormal];
    }
    if (pickRider==1) {
        //picking
        [self.btnAcept setTitle:@"Complete" forState:UIControlStateNormal];
        [unity updateTrip:requestid userID:idDriver status:@"PD" owner:self];
    }
    if (pickRider==2) {
        //pickked
        [self.btnAcept setTitle:@"Acept" forState:UIControlStateNormal];
//        [unity updateTrip:requestid userID:idDriver status:@"TC" owner:self];
        NSDictionary *rider=[TripDetail objectForKey:@"rider"];
        NSString *name=[NSString stringWithFormat:@"%@ %@",[rider objectForKey:@"firstName"],[rider objectForKey:@"lastName"]];
        NSString *phone=[rider objectForKey:@"phone"];

        PaymentViewController *payment = [[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
        payment.vcParent = self;
        payment.nameRider.text=name;
        payment.phone=phone;
        [self presentPopupViewController:payment animated:YES completion:^(void) {
            NSLog(@"popup view presented");
        }];
        
        [self.mapview removeOverlays:self.mapview.overlays];
        NSInteger toRemoveCount = mapview.annotations.count;
        NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
        for (id annotation in mapview.annotations)
            if (annotation != mapview.userLocation)
                [toRemove addObject:annotation];
        [mapview removeAnnotations:toRemove];
        self.ViewDetail.hidden=YES;
        pickRider=0;

    }
}

- (IBAction)Cancel:(id)sender {
    NSString* requestid = [[NSUserDefaults standardUserDefaults] stringForKey:@"requestID"];
    NSString* idDriver = [[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"];
    [unity updateTrip:requestid userID:idDriver status:@"CA" owner:self];
    self.ViewDetail.hidden=YES;
}

- (void) getReverseGeocode:(CLLocationCoordinate2D) coordinate
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocationCoordinate2D myCoOrdinate;

    CLLocation *location = [[CLLocation alloc] initWithLatitude:myCoOrdinate.latitude longitude:myCoOrdinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             NSLog(@"failed with error: %@", error);
             return;
         }
         if(placemarks.count > 0)
         {
             NSString *address = @"";
             CLPlacemark *placemark = placemarks[0];
             if([placemark.addressDictionary objectForKey:@"FormattedAddressLines"] != NULL) {
                 address = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             } else {
                 address = @"Address Not founded";
             }
            [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressFrom"];
   
         }
     }];
    
}

- (IBAction)setMylocation:(id)sender {
    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [latitude floatValue] ;
    region.center.longitude = [longitude floatValue];
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [self.mapview setRegion:region animated:YES];
}

- (void)findWay {
    
// find way
    [self.mapview removeOverlays:self.mapview.overlays];
    
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    
    [directionsRequest setSource:[[MKMapItem alloc] initWithPlacemark:placeFrom]];
    [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placeTo]];
    
    directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            routeDetails = response.routes.lastObject;
            [self.mapview addOverlay:routeDetails.polyline];
        }
    }];
    CLLocation *pinLocation = [[CLLocation alloc]
                               initWithLatitude:placeFrom.coordinate.latitude
                               longitude:placeFrom.coordinate.longitude];
    
    CLLocation *userLocation = [[CLLocation alloc]
                                initWithLatitude:placeTo.coordinate.latitude
                                longitude:placeTo.coordinate.longitude];
    
    CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
    NSLog(@"distance: %4.0f m",distance);
    [[NSUserDefaults standardUserDefaults] setFloat:distance forKey:@"distance"];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor colorWithRed:255/255.0f green:59/255.0f blue:0/255.0f alpha:1.0f];
    routeLineRenderer.lineWidth = 3;
    return routeLineRenderer;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
        
    }
}
@end
