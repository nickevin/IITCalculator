//
//  SettingsController.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-10-7.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SettingsView.h"
 
@protocol SettingsControllerDelegate <NSObject>

- (void)settingsDidChangeWithPMU:(double)pmu housingFund:(double)housingFund;

@end

@interface SettingsController : ZenPushViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, weak) id<SettingsControllerDelegate> delegate;

- (IBAction)sendFeedback:(id)sender;
- (IBAction)presentTaxSheetController:(id)sender;
- (IBAction)presentAboutController:(id)sender;

@end
