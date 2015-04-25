//
//  AddTripViewController.m
//  TaxiNetDriver
//
//  Created by Louis Nhat on 4/23/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "AddTripViewController.h"
#import "unity.h"
@interface AddTripViewController ()

@end

@implementation AddTripViewController
{
    UITapGestureRecognizer *gestureFrom, *gestureTo, *gestureTime, *gestureSheet;
    BOOL fromselect;
    int locationTabPosition;
    CLLocationCoordinate2D coordinateFrom;
    CLLocationCoordinate2D coordinateTo;
    NSArray *numbershet;
    BOOL saveLocation;

}
@synthesize viewDetailFrom,viewDetailTo,mImageFocus,mapview,viewDetailSheet,viewDetailTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    fromselect=FALSE;
    saveLocation=FALSE;
    // Do any additional setup after loading the view.
    mImageFocus.layer.anchorPoint = CGPointMake(0.5, 1.0);
    mapview.delegate = self;
//    mImageFocus.hidden=YES;
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:1];
    gestureFrom = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(selectLocationFrom:)];
    [self.viewDetailFrom addGestureRecognizer:gestureFrom];
    
    gestureTo = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(selectLocationTo:)];
    [self.viewDetailTo addGestureRecognizer:gestureTo];
    
    gestureTime = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(selectLocationTime:)];
    [self.viewDetailTime addGestureRecognizer:gestureTime];
    
    gestureSheet = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(selectLocationSheet:)];
    [self.viewDetailSheet addGestureRecognizer:gestureSheet];
    
    [self selectLocationFrom:gestureFrom];
    
    [self.viewDetail setBackgroundColor:[UIColor colorWithRed:84.0f/255.0f
                                                        green:142.0f/255.0f
                                                         blue:209.0f/255.0f
                                                        alpha:1.0f]];
    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:@"longitudeTo"];
    [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:@"latitudeTo"];
    
    self.DatePicker.date = [NSDate date];
    numbershet  = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6" , nil];

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return numbershet.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [numbershet objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    NSString *sheet=[numbershet objectAtIndex:row];
    [[NSUserDefaults standardUserDefaults] setObject:sheet forKey:@"SheetFreePromotinTrip"];
}
- (void)selectLocationTime:(UITapGestureRecognizer *)recognizer {
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.ViewPicker.frame;
    frame.origin.y=368;
    self.ViewPicker.frame=frame;
    [UIView commitAnimations];
}
- (void)selectLocationSheet:(UITapGestureRecognizer *)recognizer {
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.viewPickerSheet.frame;
    frame.origin.y=368;
    self.viewPickerSheet.frame=frame;
    [UIView commitAnimations];
}
- (void)selectLocationFrom:(UITapGestureRecognizer *)recognizer {
    [mImageFocus setImage:[UIImage imageNamed:@"fromMap.png"]];
    NSString *longitudeFrom,*latitudeFrom;
    if (fromselect==TRUE) {
        if (saveLocation==FALSE) {
            longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
            latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
        }
        else{
            longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFromTrip"];
            latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFromTrip"];
        }
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = [latitudeFrom floatValue] ;
        region.center.longitude = [longitudeFrom floatValue];
        region.span.longitudeDelta = 0.05f;
        region.span.latitudeDelta = 0.05f;
        [self.mapview setRegion:region animated:YES];
        locationTabPosition = 0;
        
        NSInteger toRemoveCount = mapview.annotations.count;
        NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
        for (id annotation in mapview.annotations)
            if (annotation != mapview.userLocation)
                [toRemove addObject:annotation];
        [mapview removeAnnotations:toRemove];
        JPSThumbnail *annotation = [[JPSThumbnail alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([latitudeFrom floatValue], [longitudeFrom floatValue]);
        annotation.image = [UIImage imageNamed:@"fromMap.png"];
        
        [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotation]];
        
        NSString *longitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeToTrip"];
        NSString *latitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeToTrip"];
        JPSThumbnail *annotationTo = [[JPSThumbnail alloc] init];
        annotationTo.coordinate = CLLocationCoordinate2DMake([latitudeTo floatValue], [longitudeTo floatValue]);
        annotationTo.image = [UIImage imageNamed:@"toMap.png"];
        [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotationTo]];
    }
    
}
- (void)selectLocationTo:(UITapGestureRecognizer *)recognizer {
    [mImageFocus setImage:[UIImage imageNamed:@"toMap.png"]];
    fromselect=TRUE;
    NSString *longitudeTo,*latitudeTo;
        if (saveLocation==FALSE) {
            longitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeTo"];
            latitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeTo"];
        }
        else{
            longitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeToTrip"];
            latitudeTo = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeToTrip"];
        }
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [latitudeTo floatValue] ;
    region.center.longitude = [longitudeTo floatValue];
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [self.mapview setRegion:region animated:YES];
    locationTabPosition = 1;
    
    NSInteger toRemoveCount = mapview.annotations.count;
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
    for (id annotation in mapview.annotations)
        if (annotation != mapview.userLocation)
            [toRemove addObject:annotation];
    [mapview removeAnnotations:toRemove];
    JPSThumbnail *annotationTo = [[JPSThumbnail alloc] init];
    annotationTo.coordinate = CLLocationCoordinate2DMake([latitudeTo floatValue], [longitudeTo floatValue]);
    annotationTo.image = [UIImage imageNamed:@"toMap.png"];
    [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotationTo]];
    
    
    NSString *longitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFromTrip"];
    NSString *latitudeFrom = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFromTrip"];
    JPSThumbnail *annotation = [[JPSThumbnail alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake([latitudeFrom floatValue], [longitudeFrom floatValue]);
    annotation.image = [UIImage imageNamed:@"fromMap.png"];
    [self.mapview addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:annotation]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void) getReverseGeocode:(CLLocationCoordinate2D) coordinate
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocationCoordinate2D myCoOrdinate;
    
    myCoOrdinate.latitude = coordinate.latitude;
    myCoOrdinate.longitude = coordinate.longitude;
    NSString *lotu = [NSString stringWithFormat:@"%.8f", coordinate.longitude];
    NSString *lati = [NSString stringWithFormat:@"%.8f", coordinate.latitude];
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
             NSString *city = @"";
             CLPlacemark *placemark = placemarks[0];
             
             if([placemark.addressDictionary objectForKey:@"FormattedAddressLines"] != NULL) {
                 address = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             } else {
                 address = @"Address Not founded";
             }
             if ([placemark.addressDictionary objectForKey:@"SubAdministrativeArea"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"SubAdministrativeArea"];
             else if([placemark.addressDictionary objectForKey:@"City"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"City"];
             else if([placemark.addressDictionary objectForKey:@"Country"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"Country"];
             else
                 city = @"City Not founded";
             
             if (locationTabPosition == 0) {
                 self.txtAdressFrom.text = address;
                 [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressFromTrip"];
                 if ([address length]>30) {
                     self.txtAdressFrom.text=[address substringToIndex:[address length] - 27];
                     [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressFromTrip"];
                 }
                 
                 [[NSUserDefaults standardUserDefaults] setObject:lotu forKey:@"longitudeFromTrip"];
                 [[NSUserDefaults standardUserDefaults] setObject:lati forKey:@"latitudeFromTrip"];
                 
             } else {
                 self.txtAdressTo.text = address;
                 [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressToTrip"];
                 if ([address length]>30) {
                     self.txtAdressTo.text=[address substringToIndex:[address length] - 27];
                     [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"adressToTrip"];
                 }
                 [[NSUserDefaults standardUserDefaults] setObject:lotu forKey:@"longitudeToTrip"];
                 [[NSUserDefaults standardUserDefaults] setObject:lati forKey:@"latitudeToTrip"];
             }
             
             
         }
     }];
    
}
- (void)getCoor {
    CGPoint point = mImageFocus.frame.origin;
    point.x = point.x + mImageFocus.frame.size.width / 2;
    point.y = point.y + mImageFocus.frame.size.height;
    if (locationTabPosition == 0) {
        coordinateFrom = [mapview convertPoint:point toCoordinateFromView:mapview];
        [self getReverseGeocode:coordinateFrom];
    } else {
        coordinateTo = [mapview convertPoint:point toCoordinateFromView:mapview];
        [self getReverseGeocode:coordinateTo];
    }
    
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
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self getCoor];
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
- (IBAction)AddPromotionTrip:(id)sender {
    if ([self.txtSheetFree.text isEqualToString:@""] || [self.txtAdressTo.text isEqualToString:@""]|| [self.txtDateTime.text isEqualToString:@""] || [self.txtSheetFree.text isEqualToString:@""]) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Add Error" message:@"please input text" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
    }
    else
    {
        NSString* idDriver = [[NSUserDefaults standardUserDefaults] stringForKey:@"idDriver"];
        NSString* fromLongitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeFromTrip"];
        NSString* fromLatitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeFromTrip"];
        NSString* fromAddress = [[NSUserDefaults standardUserDefaults] stringForKey:@"adressFromTrip"];
        NSString* toLongitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitudeToTrip"];
        NSString* toLatitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitudeToTrip"];
        NSString* toAddress = [[NSUserDefaults standardUserDefaults] stringForKey:@"adressToTrip"];
        NSString* time = [[NSUserDefaults standardUserDefaults] stringForKey:@"TimePromotinTrip"];
        NSString* numberOfseat = self.txtSheetFree.text;
        
        
        NSString *data = [NSString stringWithFormat:@"{\"id\":\"%@\",\"fromLongitude\":\"%@\",\"fromLatitude\":\"%@\",\"toAddress\":\"%@\",\"fromAddress\":\"%@\",\"toLongitude\":\"%@\",\"toLatitude\":\"%@\",\"time\":\"%@\",\"numberOfseat\":\"%@\",\"fromCity\":\"Ha Noi\",\"toCity\":\"Ha Noi\",\"fee\":\"500000\"}",idDriver,fromLongitude,fromLatitude,toAddress,fromAddress,toLongitude,toLatitude,time,numberOfseat];
        
        NSLog(@"%@", data);
        
        NSData *plainData = [data dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64String = [plainData base64EncodedStringWithOptions:0];
        [unity AddPromotionTrip:base64String];
    }
}
- (IBAction)cancelPicker:(id)sender {
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.ViewPicker.frame;
    frame.origin.y=568;
    self.ViewPicker.frame=frame;
    [UIView commitAnimations];
}

- (IBAction)savePicker:(id)sender {
    NSDate *myDate = self.DatePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyy-MM-dd-HH-mm"];
    NSString * time= [dateFormat stringFromDate:myDate];
    self.txtDateTime.text=time;
    [[NSUserDefaults standardUserDefaults] setObject:time forKey:@"TimePromotinTrip"];

    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.ViewPicker.frame;
    frame.origin.y=568;
    self.ViewPicker.frame=frame;
    [UIView commitAnimations];

}
- (IBAction)CancelSheet:(id)sender {
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.viewPickerSheet.frame;
    frame.origin.y=568;
    self.viewPickerSheet.frame=frame;
    [UIView commitAnimations];
}

- (IBAction)SaveSheet:(id)sender {
    NSString *setfree = [[NSUserDefaults standardUserDefaults] stringForKey:@"SheetFreePromotinTrip"];
    self.txtSheetFree.text=setfree;
    [UIView beginAnimations:@"animateAddContentView" context:nil];
    [UIView setAnimationDuration:0.4];
    CGRect frame=self.viewPickerSheet.frame;
    frame.origin.y=568;
    self.viewPickerSheet.frame=frame;
    [UIView commitAnimations];
}
- (IBAction)Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
