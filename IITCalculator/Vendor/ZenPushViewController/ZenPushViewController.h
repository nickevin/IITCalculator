//
//  ZenPushViewController.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-12-23.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZenPushViewControllerDelegate <NSObject>

@optional

- (void)didPanToPositionX;

@end

#define PUSH_VIEW_THRESHOLD 150.0f

@interface ZenPushViewController : UIViewController <ZenPushViewControllerDelegate>

@property (nonatomic, weak) id<ZenPushViewControllerDelegate> subDelegate;

@end