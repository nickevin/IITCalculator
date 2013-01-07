//
//  SettingsController.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-10-7.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "SettingsController.h"
#import "TaxSheetController.h"
#import "AboutController.h"

@interface SettingsController () {

}

// outlets
@property (nonatomic, strong) SettingsView *settingsView;

@property (nonatomic, assign) double pmu;
@property (nonatomic, assign) double housingFund;

@end

@implementation SettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"user-settings.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSDictionary *map = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        _settingsView.tfPMU.text = [FormatUtils formatCurrency:[[map valueForKey:@"pmu"] doubleValue]];
        _settingsView.tfHousingFund.text = [FormatUtils formatCurrency:[[map valueForKey:@"housingFund"] doubleValue]];
    }
}

- (void)initUI {
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTexture"]];

//    [self.tableView setBackgroundView:nil];
//    self.tableView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BackgroundTexture"]];


    _settingsView = [[SettingsView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    [self.view addSubview:_settingsView];
    
    _settingsView.tfPMU.delegate = self;
    _settingsView.tfHousingFund.delegate = self;
    
    _settingsView.keyboardView = [[ZenKeyboard alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    _settingsView.keyboardView.textField = _settingsView.tfPMU;
    
    _settingsView.keyboardView = [[ZenKeyboard alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    _settingsView.keyboardView.textField = _settingsView.tfHousingFund;
    
    [_settingsView.btnTaxSheet addTarget:self action:@selector(presentTaxSheetController) forControlEvents:UIControlEventTouchUpInside];
    [_settingsView.btnFeedback addTarget:self action:@selector(sendFeedback) forControlEvents:UIControlEventTouchUpInside];
    [_settingsView.btnAbout addTarget:self action:@selector(presentAboutController) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    double val = [FormatUtils formatDoubleWithCurrency:textField.text];
    int tmp = (int)val;
    
    if (val == 0) {
        textField.text = @"0.00";
    } else if (val == tmp) { // 无小数
        textField.text = [NSString stringWithFormat:@"%.0f", val];
    } else {
        textField.text = [NSString stringWithFormat:@"%.2f", val];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.textColor = [UIColor darkGrayColor];
    double val = [FormatUtils formatDoubleWithCurrency:textField.text];
    textField.text = [FormatUtils formatCurrency:val];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)sendFeedback {
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDict objectForKey:@"CFBundleDisplayName"];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [infoDict objectForKey:@"CFBundleVersion"];
    NSString *device = [UIDevice currentDevice].model;
    NSString *iOS = [[UIDevice currentDevice] systemVersion];

    controller.mailComposeDelegate = self;
    [controller setToRecipients:@[@"nickevin@gmail.com"]];
    [controller setSubject:[NSString stringWithFormat:@"关于[%@]_意见反馈", appName]];
    [controller setMessageBody:[NSString stringWithFormat:@"\n\n\n\n\n------------------------------\nVersion: %@(%@)\nDevice Model: %@\niOS Vesion: %@\n------------------------------", version, build, device, iOS] isHTML:NO];
    
    [self presentModalViewController:controller animated:YES];
}

- (void)presentTaxSheetController {
    TaxSheetController *controller = [[TaxSheetController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)presentAboutController {
    AboutController *controller = [[AboutController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self writeToPlist];
    
//    [self.delegate settingsDidChangeWithPMU:[FormatUtils formatDoubleWithCurrency:_tfPMU.text] housingFund:[FormatUtils formatDoubleWithCurrency:_tfHousingFund.text]];
}

- (void)writeToPlist {
    _pmu = [FormatUtils formatDoubleWithCurrency:_settingsView.tfPMU.text];
    _housingFund = [FormatUtils formatDoubleWithCurrency:_settingsView.tfHousingFund.text];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"user-settings.plist"];
    NSMutableDictionary *map =[[NSMutableDictionary alloc] init];
    [map setValue:[NSNumber numberWithDouble:_pmu] forKey:@"pmu"];
    [map setValue:[NSNumber numberWithDouble:_housingFund] forKey:@"housingFund"];
    [map writeToFile:plistPath atomically:YES];
}

- (void)viewDidUnload {
    [self _viewDidUnload];
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    if (self.isViewLoaded && !self.view.window) {
        [self _viewDidUnload];
    }
}

- (void)_viewDidUnload {
    _settingsView = nil;
}

@end
