//
//  MapController.h
//  NZKeyboard
//
//  Created by Kevin Nick on 2012-11-11.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"


@protocol MapControllerDelegate <NSObject>

- (void)annotationDidSelect:(City *)city;

@end

@interface MapController : UIViewController <MKMapViewDelegate>

// outlets
@property (strong, nonatomic) MKMapView *mapView;

@property (nonatomic, weak) id<MapControllerDelegate> delegate;
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, strong) NSMutableDictionary *config;

- (id)initWithConfig:(NSMutableDictionary *)config;

@end
