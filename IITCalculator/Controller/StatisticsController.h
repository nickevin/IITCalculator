//
//  StatisticsController.h
//  NZKeyboard
//
//  Created by Kevin Nick on 2012-11-16.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StatisticsView.h"

#import "IITCalculator.h"
#import "Statistics.h"

@interface StatisticsController : UIViewController <XYPieChartDataSource, XYPieChartDelegate, UIActionSheetDelegate, MFMessageComposeViewControllerDelegate, UISplitViewControllerDelegate>

// outlets
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) StatisticsView *statisticsView;

// model
@property (nonatomic, strong) IITCalculator *calculator;
@property (nonatomic, strong) Statistics *statistics;

- (id)initWithIITCalculator:(IITCalculator *)calculator statistics:(Statistics *)statistics;

@end
