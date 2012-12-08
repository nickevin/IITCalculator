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

@interface SettingsController ()

@end

@implementation SettingsController

 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initValue];
}

- (void)initUI {
    self.title = @"设置";

    UIImage * backgroundImage = [UIImage imageNamed:@"BackgroundTexture"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        
    _tfPMU.delegate = self;
    _tfHousingFund.delegate = self;
    
    _keyboardView = [[ZenKeyboard alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    _keyboardView.textField = _tfPMU;
    
    _keyboardView = [[ZenKeyboard alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    _keyboardView.textField = _tfHousingFund;
}

- (void)initValue {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"user-settings.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSDictionary *map = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        _tfPMU.text = [FormatUtils formatCurrency:[[map valueForKey:@"pmu"] doubleValue]];
        _tfHousingFund.text = [FormatUtils formatCurrency:[[map valueForKey:@"housingFund"] doubleValue]];
    }
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

- (IBAction)sendFeedback:(id)sender {
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

- (IBAction)presentTaxSheet:(id)sender {
    TaxSheetController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TaxSheetController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)presentAbout:(id)sender {
    AboutController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutController"];
    [self.navigationController pushViewController:controller animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self writeToPlist];
    
    [self.delegate settingsDidChangeWithPMU:[FormatUtils formatDoubleWithCurrency:_tfPMU.text]
                                housingFund:[FormatUtils formatDoubleWithCurrency:_tfHousingFund.text]];
}

- (void)writeToPlist {
    _pmu = [FormatUtils formatDoubleWithCurrency:_tfPMU.text];
    _housingFund = [FormatUtils formatDoubleWithCurrency:_tfHousingFund.text];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"user-settings.plist"];
    NSMutableDictionary *map =[[NSMutableDictionary alloc]init];
    [map setValue:[NSNumber numberWithDouble:_pmu] forKey:@"pmu"];
    [map setValue:[NSNumber numberWithDouble:_housingFund] forKey:@"housingFund"];
    [map writeToFile:plistPath atomically:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)viewDidUnload {
    [self setTfPMU:nil];
    [self setTfHousingFund:nil];
    [self setKeyboardView:nil];
    
    [super viewDidUnload];
}

@end
