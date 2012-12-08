//
//  MKMapView.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-26.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

- (MKCoordinateRegion)coordinateRegionWithMapView:(MKMapView *)mapView
                                 centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                     andZoomLevel:(NSUInteger)zoomLevel;
- (NSUInteger)zoomLevel;

@end
