//
//  SettingsView.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-12-26.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsView : UIView

@property (strong, nonatomic) ZenListView *listCustomize;
@property (strong, nonatomic) ZenListView *listSection;

@property (nonatomic, strong) UIButton *btnTaxSheet;
@property (nonatomic, strong) UIButton *btnFeedback;
@property (nonatomic, strong) UIButton *btnAbout;

@property (nonatomic, strong) ZenTextField *tfPMU;
@property (nonatomic, strong) ZenTextField *tfHousingFund;
@property (nonatomic, strong) ZenKeyboard *keyboardView;

@end
