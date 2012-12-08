//
//  SettingsController.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-10-7.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@protocol SettingsControllerDelegate <NSObject>

- (void)settingsDidChangeWithPMU:(double)pmu housingFund:(double)housingFund;

@end

@interface SettingsController : UITableViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

// outlets
@property (weak, nonatomic) IBOutlet ZenTextField *tfPMU;
@property (weak, nonatomic) IBOutlet ZenTextField *tfHousingFund;
@property (nonatomic, strong) ZenKeyboard *keyboardView;

@property (nonatomic, weak) id<SettingsControllerDelegate> delegate;

@property (nonatomic, assign) double pmu;
@property (nonatomic, assign) double housingFund;


- (IBAction)sendFeedback:(id)sender;
- (IBAction)presentTaxSheet:(id)sender;
- (IBAction)presentAbout:(id)sender;


@end
