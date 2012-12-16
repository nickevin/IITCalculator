//
//  MapController.m
//  NZKeyboard
//
//  Created by Kevin Nick on 2012-11-11.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "MapController.h"
#import "UIViewController+KNSemiModal.h"

#define GEORGIA_TECH_LATITUDE 35.33
#define GEORGIA_TECH_LONGITUDE 103.23

@interface MapController ()

@end

@implementation MapController

- (id)initWithConfig:(NSDictionary *)config {
    if (self = [super init]) {
        _config = config;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    [self setMapView];
}

- (void)initUI {
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, 320, screenHeight - 60);
    
    UIImageView *navigationBarImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    navigationBarImage.image = [UIImage imageNamed:@"MapViewNavigationBar"];
    
    UIButton *refreshButton = [self createRefreshButton];
    UIButton *doneButton = [self createDoneButton];
    
    [self.view addSubview:navigationBarImage];
    [self.view addSubview:refreshButton];
    [self.view addSubview:doneButton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 45, 320, self.view.frame.size.height - 45)];
        _mapView.delegate = self;

        [self.view addSubview:_mapView];
    });

}

- (UIButton *)createRefreshButton {
    UIImage *buttonImage = [UIImage imageNamed:@"RefreshIcon"];
    UIImage *buttonPressedImage = [UIImage imageNamed:@"RefreshIconPushed"];
    CGRect frame = CGRectMake(5, (44 - buttonImage.size.height) / 2, buttonImage.size.width, buttonImage.size.height);
    UIButton *button = [UIFactory createButtonWithFrame:frame normalBackground:buttonImage highlightedBackground:buttonPressedImage];
    [button addTarget:self action:@selector(refreshMapView) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIButton *)createDoneButton {
    UIImage *buttonImage = [UIImage imageNamed:@"DoneIcon"];
    UIImage *buttonPressedImage = [UIImage imageNamed:@"DoneIconPushed"];
    CGRect frame = CGRectMake(320 - buttonImage.size.width - 5, (44 - buttonImage.size.height) / 2, buttonImage.size.width, buttonImage.size.height);
    UIButton *button = [UIFactory createButtonWithFrame:frame normalBackground:buttonImage highlightedBackground:buttonPressedImage];
    [button addTarget:self action:@selector(dismissSemiModalView) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)setMapView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        if (_currentCity) {
            City *city = [_config objectForKey:_currentCity];
            CLLocationCoordinate2D centerCoord = {city.coordinate.latitude, city.coordinate.longitude};
            [_mapView setRegion:MKCoordinateRegionMake(centerCoord, MKCoordinateSpanMake(5, 5)) animated:YES];
        } else {
            CLLocationCoordinate2D centerCoord = {GEORGIA_TECH_LATITUDE, GEORGIA_TECH_LONGITUDE};
            [_mapView setRegion:MKCoordinateRegionMake(centerCoord, MKCoordinateSpanMake(10, 10)) animated:YES];
        }
        
        for (id key in _config) {
            City *city = [_config objectForKey:key];
            [_mapView addAnnotation:city];
        }
    });
}

- (void)refreshMapView {
    [self setMapView];
}

- (void)dismissSemiModalView {
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *mapPin = nil;
    if(annotation != _mapView.userLocation) {        
        static NSString *defaultPinId = @"defaultPin";
        mapPin = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinId];
        if (mapPin == nil) {
            mapPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                     reuseIdentifier:defaultPinId];
            mapPin.canShowCallout = YES;
            // mapPin.animatesDrop = YES;
            UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            mapPin.rightCalloutAccessoryView = infoButton;
            
            NSString *region = ((City *)annotation).region;
            if ([@"North" isEqualToString:region]) {
                UIImage * image = [UIImage imageNamed:@"PinBlue"];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-15, 0, image.size.width, image.size.height)];
                imageView.image = image;
                [mapPin addSubview:imageView];
            } else if ([@"East" isEqualToString:region]) {
                UIImage * image = [UIImage imageNamed:@"PinYellow"];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-15, 0, image.size.width, image.size.height)];
                imageView.image = image;
                [mapPin addSubview:imageView];
            } else if ([@"Central" isEqualToString:region]) {
                UIImage * image = [UIImage imageNamed:@"PinGreen"];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-15, 0, image.size.width, image.size.height)];
                imageView.image = image;
                [mapPin addSubview:imageView];
            } else if ([@"South" isEqualToString:region]) {
                UIImage * image = [UIImage imageNamed:@"PinPink"];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-15, 0, image.size.width, image.size.height)];
                imageView.image = image;
                [mapPin addSubview:imageView];
            } else if ([@"Northeast" isEqualToString:region]) {
                mapPin.pinColor = MKPinAnnotationColorGreen ;
            } else if ([@"Northwest" isEqualToString:region]) {
                mapPin.pinColor =  MKPinAnnotationColorPurple;
            } else if ([@"Southwest" isEqualToString:region]) {
                mapPin.pinColor = MKPinAnnotationColorRed;
            }
        } else {
            mapPin.annotation = annotation;
        }
    }
    
    return mapPin;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)annotationViews {
    for (MKAnnotationView *annView in annotationViews) {
        CGRect endFrame = annView.frame;
        annView.frame = CGRectOffset(endFrame, 0, -500);
        [UIView animateWithDuration:0.8
                         animations:^{ annView.frame = endFrame;}];
    }
    
    [_mapView selectAnnotation:[_config valueForKey:_currentCity] animated:NO];
    
    //    [self performSelector:@selector(selectAnnotation) withObject:nil afterDelay:1];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    City *city = (City *)[view annotation];
    [self.delegate annotationDidSelect:city];
    [self dismissSemiModalView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    self.mapView = nil;
    
    [super viewDidUnload];
}

@end
