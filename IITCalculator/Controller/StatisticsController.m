//
//  StatisticsController.m
//  NZKeyboard
//
//  Created by Kevin Nick on 2012-11-16.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "StatisticsController.h"
#import "SVWebViewController.h"
#import "SDSegmentedControl.h"

@interface StatisticsController () {
    
}

// outlets
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) StatisticsView *statisticsView;
@property (nonatomic, strong) UIImageView *coachMarksView;

@property (nonatomic, strong) NSMutableArray *slices;
@property (nonatomic, strong) NSArray *sliceColors;

@end

@implementation StatisticsController

- (id)initWithIITCalculator:(IITCalculator *)calculator
                 statistics:(Statistics *)statistics {
    if (self = [super init]) {
        _calculator = calculator;
        _statistics = statistics;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initCoachMarks];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, ANIMATION_DURATION * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            _statisticsView.frame = CGRectMake(0, 0, _statisticsView.frame.size.width, _statisticsView.frame.size.height);
            _segmentedControl.frame = CGRectMake(0, 0, _segmentedControl.frame.size.width, _segmentedControl.frame.size.height);
        } completion:^(BOOL finished) {
            [self reloadStatistics];            
        }];
    });
 }

- (void)initCoachMarks {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    int runCount = [userDefaults boolForKey:@"runCount"];
    if (runCount == 0) {
        UIImage *coachMarks = [UIImage imageNamed:@"ViewCoachMarks"];
        _coachMarksView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, coachMarks.size.width, coachMarks.size.height)];
        _coachMarksView.image = coachMarks;
        _coachMarksView.alpha = 0.0;

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture)];
        [_coachMarksView setUserInteractionEnabled:YES];
        [_coachMarksView addGestureRecognizer:tapGesture];
        
        [self.view.window addSubview:_coachMarksView];
        
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationCurveEaseOut animations:^{
            _coachMarksView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [userDefaults setInteger:1 forKey:@"runCount"];
        }];
    }
}

- (void)initUI {    
    self.title = @"统计明细";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTexture"]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ActionIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(presentActionSheet)];
        
    UIImage *shadow = [UIImage imageNamed:@"NavigationBarShadow"];
    UIImageView *shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -3, 320, 6)];
    shadowView.image = shadow;
    [self.view addSubview:shadowView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        CGFloat contentHeight = [UIScreen mainScreen].bounds.size.height == 568 ? self.view.frame.size.height * 2.15: self.view.frame.size.height * 2.6;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, contentHeight);
        [self.view addSubview:_scrollView];
            
        _statisticsView = [[StatisticsView alloc] initWithFrame:CGRectMake(-320, 0, 320, contentHeight)];
        [_scrollView addSubview:_statisticsView];
        
        [self initSegmentedControlUI];
        
        _actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        //    [_actionSheet addButtonWithTitle:@"发送短信"];
        [_actionSheet addButtonWithTitle:@"复制信息"];
        [_actionSheet addButtonWithTitle:@"取消"];
        _actionSheet.cancelButtonIndex = [_actionSheet numberOfButtons] - 1;
        
        self.sliceColors = @[RGB(240, 40, 50),
                            RGB(220, 190, 0),
                            RGB(0, 150, 200),
                            RGB(210, 100, 5),
                            RGB(229, 66, 115),
                            RGB(100, 180, 50)];
    });
}

- (void)initSegmentedControlUI {
    NSArray *categories = @[@"个人统计", @"企业统计"];
    _segmentedControl = [[SDSegmentedControl alloc] initWithItems:categories];
    _segmentedControl.frame = CGRectMake(0, -50, 320, 44);
    [_segmentedControl setSelectedSegmentIndex:0];
    [_segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segmentedControl];
}

- (void)segmentedControlChanged:(UISegmentedControl *)segmentedControl {
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:ANIMATION_DURATION * 2 delay:ANIMATION_DURATION * 3 options:UIViewAnimationCurveEaseOut animations:^{
            _statisticsView.frame = CGRectMake(-320, 0, _statisticsView.frame.size.width, _statisticsView.frame.size.height);
            
        } completion:^(BOOL finished) {
            _statisticsView.frame = CGRectMake(320, 0, _statisticsView.frame.size.width, _statisticsView.frame.size.height);
            
            [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationCurveEaseOut animations:^{
                _statisticsView.frame = CGRectMake(0, 0, _statisticsView.frame.size.width, _statisticsView.frame.size.height);
            } completion:^(BOOL finished) {
                _statistics = [_calculator calc:_statistics.preTaxIncome city:_statistics.city.name mode:0];
                
                [self reloadStatistics];
            }];
        }];
    } else {
        [UIView animateWithDuration:ANIMATION_DURATION * 2 delay:ANIMATION_DURATION * 3 options:UIViewAnimationCurveEaseOut animations:^{
            _statisticsView.frame = CGRectMake(320, 0, _statisticsView.frame.size.width, _statisticsView.frame.size.height);
            
        } completion:^(BOOL finished) {
            _statisticsView.frame = CGRectMake(-320, 0, _statisticsView.frame.size.width, _statisticsView.frame.size.height);
            
            [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationCurveEaseOut animations:^{
                _statisticsView.frame = CGRectMake(0, 0, _statisticsView.frame.size.width, _statisticsView.frame.size.height);
            } completion:^(BOOL finished) {
                _statistics = [_calculator calc:_statistics.preTaxIncome city:_statistics.city.name mode:1];
                
                [self reloadStatistics];
            }];
        }];
    }
}

- (void)initValue {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        _statisticsView.lbPension.text = [FormatUtils formatPercent:_statistics.city.iH.pension];
        _statisticsView.lbMedicalCare.text = [FormatUtils formatPercent:_statistics.city.iH.medicalCare];
        _statisticsView.lbUnemployment.text = [FormatUtils formatPercent:_statistics.city.iH.unemployment];
        _statisticsView.lbIndustrialInjury.text = [FormatUtils formatPercent:_statistics.city.iH.industrialInjury];
        _statisticsView.lbPregnancy.text = [FormatUtils formatPercent:_statistics.city.iH.pregnancy];
        _statisticsView.lbBasicHousingFund.text = [FormatUtils formatPercent:_statistics.city.iH.basicHousingFund];
    } else {
        _statisticsView.lbPension.text = [FormatUtils formatPercent:_statistics.city.iHEnterprise.pension];
        _statisticsView.lbMedicalCare.text = [FormatUtils formatPercent:_statistics.city.iHEnterprise.medicalCare];
        _statisticsView.lbUnemployment.text = [FormatUtils formatPercent:_statistics.city.iHEnterprise.unemployment];
        _statisticsView.lbIndustrialInjury.text = [FormatUtils formatPercent:_statistics.city.iHEnterprise.industrialInjury];
        _statisticsView.lbPregnancy.text = [FormatUtils formatPercent:_statistics.city.iHEnterprise.pregnancy];
        _statisticsView.lbBasicHousingFund.text = [FormatUtils formatPercent:_statistics.city.iHEnterprise.basicHousingFund];
    }
    
    _statisticsView.lbPensionAmount.text = [FormatUtils formatCurrency:_statistics.pensionAmount];
    _statisticsView.lbMedicalCareAmount.text = [FormatUtils formatCurrency:_statistics.medicalCareAmount];
    _statisticsView.lbUnemploymentAmount.text = [FormatUtils formatCurrency:_statistics.unemploymentAmount];
    _statisticsView.lbIndustrialInjuryAmount.text = [FormatUtils formatCurrency:_statistics.industrialInjuryAmount];
    _statisticsView.lbPregnancyAmount.text = [FormatUtils formatCurrency:_statistics.pregnancyAmount];
    _statisticsView.lbBasicHousingFundAmount.text = [FormatUtils formatCurrency:_statistics.basicHousingFundAmount];
    _statisticsView.lbTotalAmount.text = [FormatUtils formatCurrency:_statistics.totalAmount];
    
    _statisticsView.lbAfterTaxIncome.text = [FormatUtils formatCurrency:_statistics.afterTaxIncome];
    _statisticsView.lbTax.text = [FormatUtils formatCurrency:_statistics.tax];
    _statisticsView.lbTaxableAmount.text = [FormatUtils formatCurrency:_statistics.taxableAmount];
    
    [_statisticsView.lbInfo setTitle:((WebSite *)[_statistics.city.info objectAtIndex:0]).name forState:UIControlStateNormal];
    [_statisticsView.lbInfo addTarget:self action:@selector(presentWebViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [_statisticsView.lbInfo2 setTitle:((WebSite *)[_statistics.city.info objectAtIndex:1]).name forState:UIControlStateNormal];
    [_statisticsView.lbInfo2 addTarget:self action:@selector(presentWebViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    _slices = [NSMutableArray arrayWithCapacity:7];
    [_slices addObject:[NSNumber numberWithDouble:_statistics.pensionAmount]];
    [_slices addObject:[NSNumber numberWithDouble:_statistics.medicalCareAmount]];
    [_slices addObject:[NSNumber numberWithDouble:_statistics.unemploymentAmount]];
    [_slices addObject:[NSNumber numberWithDouble:_statistics.industrialInjuryAmount]];
    [_slices addObject:[NSNumber numberWithDouble:_statistics.pregnancyAmount]];
    [_slices addObject:[NSNumber numberWithDouble:_statistics.basicHousingFundAmount]];
    
    _statisticsView.pieChart.delegate = self;
    _statisticsView.pieChart.dataSource = self;
}

- (void)reloadStatistics {
    [self initValue];

    [_statisticsView.pieChart reloadData];
    
    /*
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
     [_statisticsView.pieChart setSliceSelectedAtIndex:0];
     });
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
     [_statisticsView.pieChart setSliceDeselectedAtIndex:0];
     });
     
     */
}

- (void)presentWebViewController:(UIButton *)sender {
    NSURL *url;
    if (sender.tag == 1) {
        url = [NSURL URLWithString:((WebSite *)[_statistics.city.info objectAtIndex:0]).url];
    } else {
        url = [NSURL URLWithString:((WebSite *)[_statistics.city.info objectAtIndex:1]).url];
    }
    
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:url];
    webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari;
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
    return _slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
    return [[_slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index {
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate

- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index {
    if (0 == index) {
        _statisticsView.roundLabel.text = @"养老";
    } else if (1 == index) {
        _statisticsView.roundLabel.text = @"医疗";
    } else if (2 == index) {
        _statisticsView.roundLabel.text = @"失业";
    } else if (3 == index) {
        _statisticsView.roundLabel.text = @"工伤";
    } else if (4 == index) {
        _statisticsView.roundLabel.text = @"生育";
    } else if (5 == index) {
        _statisticsView.roundLabel.text = @"住房";
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    NSString *info = [self generateInfo];
    
    if ([title isEqualToString:@"发送短信"]) {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText]) {
            controller.body = info;
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
        }
    } else if ([title isEqualToString:@"复制信息"]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = info;
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)presentActionSheet {
    [_actionSheet showInView:self.view];
}

- (NSString *)generateInfo {
    return [NSString stringWithFormat:@"所在城市: %@\n税前收入: %@\n税后收入: %@\n计税金额: %@\n个人所得税: %@",
            _statistics.city.name,
            [FormatUtils formatCurrency:_statistics.preTaxIncome],
            [FormatUtils formatCurrency:_statistics.afterTaxIncome],
            [FormatUtils formatCurrency:_statistics.taxableAmount],
            [FormatUtils formatCurrency:_statistics.tax]];
}

- (void)handleTapGesture {
    [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationCurveEaseIn animations:^{
        _coachMarksView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_coachMarksView removeFromSuperview];
    }];
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
    self.calculator = nil;
    self.statistics = nil;
    self.segmentedControl = nil;
    self.statisticsView = nil;
    self.scrollView = nil;
    self.actionSheet = nil;
    self.slices = nil;
    self.sliceColors = nil;
}

@end
