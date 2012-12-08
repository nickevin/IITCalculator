//
//  IncomeDetailController.m
//  NZKeyboard
//
//  Created by Kevin Nick on 2012-11-16.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "IncomeDetailController.h"
#import "ZenListView.h"
#import "SVWebViewController.h"

@interface IncomeDetailController ()

@end

@implementation IncomeDetailController

- (id)initWithIncomeDetail:(IncomeDetail *)incomeDetail {
    if (self = [self init]) {
        _incomeDetail = incomeDetail;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    [self initValue];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_pieChart reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [_pieChart setSliceSelectedAtIndex:0];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [_pieChart setSliceDeselectedAtIndex:0];
    });
}

- (void)initUI {
    self.navigationItem.title = @"收入明细";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ActionIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(presentActionSheet)];

    UIImage * backgroundImage = [UIImage imageNamed:@"BackgroundTexture"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    UIImage *shadow = [UIImage imageNamed:@"NavigationBarShadow"];
    UIImageView *shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -3, 320, 6)];
    shadowView.image = shadow;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44)];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2.2);

    [self.view addSubview:shadowView];
    [self.view addSubview:_scrollView];
    [self initPieChartUI];
    [self setPMUUI];
    [self setIncomeTaxUI];
    [self setInfoUI];
    
    _actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [_actionSheet addButtonWithTitle:@"发送短信"];
    [_actionSheet addButtonWithTitle:@"复制信息"];
    [_actionSheet addButtonWithTitle:@"取消"];
    _actionSheet.cancelButtonIndex = [_actionSheet numberOfButtons] - 1;

}

- (void)initPieChartUI {
    UIImage *pieChartBackground = [UIImage imageNamed:@"PhotoFrame"];
    UIImageView *pieChartBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - pieChartBackground.size.width) / 2, 5, pieChartBackground.size.width, pieChartBackground.size.height)];
    pieChartBackgroundView.image = pieChartBackground;
    
    _pieChart = [[XYPieChart alloc] initWithFrame:CGRectMake((320 - 260) / 2, 11, 260, 260)];
    //    _pieChart.backgroundColor = [UIColor whiteColor];
    
    _roundLabel = [[UILabel alloc] initWithFrame:CGRectMake((320 - 90) / 2, 100, 90, 90)];
    _roundLabel.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:20.0f];
    _roundLabel.textColor = RGB(104, 114, 121);
    _roundLabel.shadowColor = [UIColor whiteColor];
    _roundLabel.shadowOffset = CGSizeMake(0, 1);
    _roundLabel.backgroundColor = RGB(234, 234, 234);
    _roundLabel.textAlignment = UITextAlignmentCenter;
    
    [_pieChart setStartPieAngle:M_PI_2];
    [_pieChart setAnimationSpeed:1.0];
    [_pieChart setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:18]];
    [_pieChart setLabelRadius:80];
    [_pieChart setShowPercentage:NO];
    //    [_pieChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [_pieChart setPieCenter:CGPointMake(_pieChart.bounds.size.width / 2, _pieChart.bounds.size.height / 2)];
    //    [_pieChart setLabelShadowColor:[UIColor blackColor]];
    
    [_roundLabel.layer setCornerRadius:_roundLabel.bounds.size.width / 2];
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    [_scrollView addSubview:pieChartBackgroundView];
    [_scrollView addSubview:_pieChart];
    [_scrollView addSubview:_roundLabel];
}

- (void)setPMUUI {
    ZenListView *listView = [[ZenListView alloc] initWithFrame:CGRectMake(0, 165, 0, 230)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 300, 280, 20)];
    title.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:20.0f];
    title.text = @"五险一金汇缴明细";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = RGB(104, 114, 121);
    
    UILabel *pensionTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, title.frame.origin.y + 60, 90, 20)];
    pensionTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    pensionTitle.text = @"养老保险金";
    pensionTitle.backgroundColor = [UIColor clearColor];
    pensionTitle.textColor = RGB(104, 114, 121);
    
    UILabel *parentheses = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, title.frame.origin.y + 60, 100, 20)];
    parentheses.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    parentheses.textColor = RGB(104, 114, 121);
    parentheses.backgroundColor = [UIColor clearColor];
    parentheses.text = @"(            )";
    
    _lbPension = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, title.frame.origin.y + 60, 60, 20)];
    _lbPension.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbPension.textColor = RGB(104, 114, 121);
    _lbPension.backgroundColor = [UIColor clearColor];
    _lbPension.textAlignment = UITextAlignmentCenter;
    
    _lbPensionAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, title.frame.origin.y + 60, 100, 20)];
    _lbPensionAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbPensionAmount.textColor = RGB(104, 114, 121);
    _lbPensionAmount.backgroundColor = [UIColor clearColor];
    _lbPensionAmount.textAlignment = UITextAlignmentRight;

    UIImage *divider = [UIImage imageNamed:@"GenericSeparator"];
    UIImageView *dividerView = [[UIImageView alloc] initWithFrame:CGRectMake(25, pensionTitle.frame.origin.y + 30, 270, 2)];
    dividerView.image = divider;
    
    UILabel *medicalCareTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, pensionTitle.frame.origin.y + pensionTitle.frame.size.height + 25, 90, 20)];
    medicalCareTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    medicalCareTitle.text = @"医疗保险金";
    medicalCareTitle.backgroundColor = [UIColor clearColor];
    medicalCareTitle.textColor = RGB(104, 114, 121);
    
    UILabel *parentheses2 = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, pensionTitle.frame.origin.y + 45, 100, 20)];
    parentheses2.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    parentheses2.textColor = RGB(104, 114, 121);
    parentheses2.backgroundColor = [UIColor clearColor];
    parentheses2.text = @"(            )";
    
    _lbMedicalCare = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, pensionTitle.frame.origin.y + 45, 60, 20)];
    _lbMedicalCare.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbMedicalCare.textColor = RGB(104, 114, 121);
    _lbMedicalCare.backgroundColor = [UIColor clearColor];
    _lbMedicalCare.textAlignment = UITextAlignmentCenter;
    
    _lbMedicalCareAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, pensionTitle.frame.origin.y + 45, 100, 20)];
    _lbMedicalCareAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbMedicalCareAmount.textColor = RGB(104, 114, 121);
    _lbMedicalCareAmount.backgroundColor = [UIColor clearColor];
    _lbMedicalCareAmount.textAlignment = UITextAlignmentRight;
    
    UIImageView *dividerView2 = [[UIImageView alloc] initWithFrame:CGRectMake(25, dividerView.frame.origin.y
                                                                              + 45, 270, 2)];
    dividerView2.image = divider;
    
    UILabel *unemploymentTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, medicalCareTitle.frame.origin.y + medicalCareTitle.frame.size.height + 25, 90, 20)];
    unemploymentTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    unemploymentTitle.text = @"失业保险金";
    unemploymentTitle.backgroundColor = [UIColor clearColor];
    unemploymentTitle.textColor = RGB(104, 114, 121);
    
    UILabel *parentheses3 = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, unemploymentTitle.frame.origin.y, 100, 20)];
    parentheses3.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    parentheses3.textColor = RGB(104, 114, 121);
    parentheses3.backgroundColor = [UIColor clearColor];
    parentheses3.text = @"(            )";
    
    _lbUnemployment = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, medicalCareTitle.frame.origin.y + 45, 60, 20)];
    _lbUnemployment.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbUnemployment.textColor = RGB(104, 114, 121);
    _lbUnemployment.backgroundColor = [UIColor clearColor];
    _lbUnemployment.textAlignment = UITextAlignmentCenter;
    
    _lbUnemploymentAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, medicalCareTitle.frame.origin.y + 45, 100, 20)];
    _lbUnemploymentAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbUnemploymentAmount.textColor = RGB(104, 114, 121);
    _lbUnemploymentAmount.backgroundColor = [UIColor clearColor];
    _lbUnemploymentAmount.textAlignment = UITextAlignmentRight;
    
    UIImageView *dividerView3 = [[UIImageView alloc] initWithFrame:CGRectMake(25, dividerView2.frame.origin.y
                                                                              + 45, 270, 2)];
    dividerView3.image = divider;
    
    UILabel *basicHousingFundTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, unemploymentTitle.frame.origin.y + unemploymentTitle.frame.size.height + 25, 90, 20)];
    basicHousingFundTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    basicHousingFundTitle.text = @"住房公积金";
    basicHousingFundTitle.backgroundColor = [UIColor clearColor];
    basicHousingFundTitle.textColor = RGB(104, 114, 121);
    
    UILabel *parentheses4 = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, basicHousingFundTitle.frame.origin.y, 100, 20)];
    parentheses4.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    parentheses4.textColor = RGB(104, 114, 121);
    parentheses4.backgroundColor = [UIColor clearColor];
    parentheses4.text = @"(            )";
    
    _lbBasicHousingFund = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, basicHousingFundTitle.frame.origin.y, 60, 20)];
    _lbBasicHousingFund.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbBasicHousingFund.textColor = RGB(104, 114, 121);
    _lbBasicHousingFund.backgroundColor = [UIColor clearColor];
    _lbBasicHousingFund.textAlignment = UITextAlignmentCenter;

    _lbBasicHousingFundAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, basicHousingFundTitle.frame.origin.y, 100, 20)];
    _lbBasicHousingFundAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbBasicHousingFundAmount.textColor = RGB(104, 114, 121);
    _lbBasicHousingFundAmount.backgroundColor = [UIColor clearColor];
    _lbBasicHousingFundAmount.textAlignment = UITextAlignmentRight;

    UIImageView *dividerView4 = [[UIImageView alloc] initWithFrame:CGRectMake(25, dividerView3.frame.origin.y
                                                                              + 45, 270, 2)];
    dividerView4.image = divider;
    
    UILabel *totleTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, basicHousingFundTitle.frame.origin.y + basicHousingFundTitle.frame.size.height + 25, 90, 20)];
    totleTitle.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:18.0f];
    totleTitle.text = @"总计";
    totleTitle.backgroundColor = [UIColor clearColor];
    totleTitle.textColor = RGB(104, 114, 121);
    
    _lbTotalAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, totleTitle.frame.origin.y, 100, 20)];
    _lbTotalAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbTotalAmount.textColor = RGB(104, 114, 121);
    _lbTotalAmount.backgroundColor = [UIColor clearColor];
    _lbTotalAmount.textAlignment = UITextAlignmentRight;

    [_scrollView addSubview:listView];
    [_scrollView addSubview:title];
    [_scrollView addSubview:pensionTitle]; [_scrollView addSubview:parentheses]; [_scrollView addSubview:_lbPension]; [_scrollView addSubview:_lbPensionAmount];
    [_scrollView addSubview:dividerView];
    
    [_scrollView addSubview:medicalCareTitle]; [_scrollView addSubview:parentheses2]; [_scrollView addSubview:_lbMedicalCare]; [_scrollView addSubview:_lbMedicalCareAmount];
    [_scrollView addSubview:dividerView2];
    
    [_scrollView addSubview:unemploymentTitle]; [_scrollView addSubview:parentheses3]; [_scrollView addSubview:_lbUnemployment]; [_scrollView addSubview:_lbUnemploymentAmount];

    [_scrollView addSubview:dividerView3];
    
    [_scrollView addSubview:basicHousingFundTitle]; [_scrollView addSubview:parentheses4]; [_scrollView addSubview:_lbBasicHousingFund]; [_scrollView addSubview:_lbBasicHousingFundAmount];
    [_scrollView addSubview:dividerView4];
    
    [_scrollView addSubview:totleTitle];  [_scrollView addSubview:_lbTotalAmount];

}

- (void)setIncomeTaxUI {
    ZenListView *listView = [[ZenListView alloc] initWithFrame:CGRectMake(0, 320, 0, 130)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 610, 280, 20)];
    title.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:20.0f];
    title.text = @"纳税明细";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = RGB(104, 114, 121);
    
    UILabel *afterTaxIncomeTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, title.frame.origin.y
                                                                             + 60, 280, 20)];
    afterTaxIncomeTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    afterTaxIncomeTitle.text = @"税后收入";
    afterTaxIncomeTitle.backgroundColor = [UIColor clearColor];
    afterTaxIncomeTitle.textColor = RGB(104, 114, 121);
    
    _lbAfterTaxIncome = [[UILabel alloc] initWithFrame:CGRectMake(185, afterTaxIncomeTitle.frame.origin.y, 100, 20)];
    _lbAfterTaxIncome.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbAfterTaxIncome.textColor = RGB(104, 114, 121);
    _lbAfterTaxIncome.backgroundColor = [UIColor clearColor];
    _lbAfterTaxIncome.textAlignment = UITextAlignmentRight;
    
    UIImage *divider = [UIImage imageNamed:@"GenericSeparator"];
    UIImageView *dividerView = [[UIImageView alloc] initWithFrame:CGRectMake(25, afterTaxIncomeTitle.frame.origin.y + 30, 270, 2)];
    dividerView.image = divider;
    
    UILabel *taxableTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, afterTaxIncomeTitle.frame.origin.y + afterTaxIncomeTitle.frame.size.height + 25, 280, 20)];
    taxableTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    taxableTitle.text = @"计税金额";
    taxableTitle.backgroundColor = [UIColor clearColor];
    taxableTitle.textColor = RGB(104, 114, 121);
    
    _lbTaxableAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, taxableTitle.frame.origin.y, 100, 20)];
    _lbTaxableAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbTaxableAmount.textColor = RGB(104, 114, 121);
    _lbTaxableAmount.backgroundColor = [UIColor clearColor];
    _lbTaxableAmount.textAlignment = UITextAlignmentRight;
    
    UIImageView *dividerView2 = [[UIImageView alloc] initWithFrame:CGRectMake(25, taxableTitle.frame.origin.y + 30, 270, 2)];
    dividerView2.image = divider;
    
    UILabel *taxTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, taxableTitle.frame.origin.y + taxableTitle.frame.size.height + 25, 280, 20)];
    taxTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    taxTitle.text = @"个人所得税";
    taxTitle.backgroundColor = [UIColor clearColor];
    taxTitle.textColor = RGB(104, 114, 121);
    
    _lbTax = [[UILabel alloc] initWithFrame:CGRectMake(185, taxTitle.frame.origin.y, 100, 20)];
    _lbTax.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbTax.textColor = RGB(104, 114, 121);
    _lbTax.backgroundColor = [UIColor clearColor];
    _lbTax.textAlignment = UITextAlignmentRight;

    [_scrollView addSubview:listView];
    [_scrollView addSubview:title];
    [_scrollView addSubview:taxableTitle]; [_scrollView addSubview:_lbTaxableAmount];
    [_scrollView addSubview:dividerView2];
    [_scrollView addSubview:taxTitle]; [_scrollView addSubview:_lbTax];
    [_scrollView addSubview:dividerView];
    [_scrollView addSubview:afterTaxIncomeTitle]; [_scrollView addSubview:_lbAfterTaxIncome];

}

- (void)setInfoUI {
    ZenListView *listView = [[ZenListView alloc] initWithFrame:CGRectMake(0, 425, 0, 85)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 820, 280, 20)];
    title.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:20.0f];
    title.text = @"相关政策";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = RGB(104, 114, 121);
    
    _lbInfo = [UIFactory createLinkButtonWithFrame:CGRectMake(30, title.frame.origin.y
                                                                       + 60, 250, 20)];
    _lbInfo.titleLabel.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    [_lbInfo setTitleColor:RGB(104, 114, 121) forState:UIControlStateNormal];
    _lbInfo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIButton *btnChevron = [UIFactory createButtonWithFrame:CGRectMake(275, title.frame.origin.y + 60, 9, 14)
                                           normalBackground:[UIImage imageNamed:@"DetailItemArrow"]
                                      highlightedBackground:nil];
    
    UIImage *divider = [UIImage imageNamed:@"GenericSeparator"];
    UIImageView *dividerView = [[UIImageView alloc] initWithFrame:CGRectMake(25, _lbInfo.frame.origin.y + 30, 270, 2)];
    dividerView.image = divider;
    
    _lbInfo2 = [UIFactory createLinkButtonWithFrame:CGRectMake(30, _lbInfo.frame.origin.y + _lbInfo.frame.size.height + 25, 280, 20)];
    _lbInfo2.titleLabel.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    [_lbInfo2 setTitleColor:RGB(104, 114, 121) forState:UIControlStateNormal];
    _lbInfo2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIButton *btnChevron2 = [UIFactory createButtonWithFrame:CGRectMake(275, _lbInfo.frame.origin.y + _lbInfo.frame.size.height + 25, 9, 14)
                                           normalBackground:[UIImage imageNamed:@"DetailItemArrow"]
                                      highlightedBackground:nil];
    
    [_scrollView addSubview:listView];
    [_scrollView addSubview:title];
    [_scrollView addSubview:_lbInfo2];
    [_scrollView addSubview:btnChevron];
    [_scrollView addSubview:dividerView];
    [_scrollView addSubview:_lbInfo];
    [_scrollView addSubview:btnChevron2];

}

- (void)initPieChart {
    _slices = [NSMutableArray arrayWithCapacity:5];
    [_slices addObject:[NSNumber numberWithDouble:_incomeDetail.pensionAmount]];
    [_slices addObject:[NSNumber numberWithDouble:_incomeDetail.medicalCareAmount]];
    [_slices addObject:[NSNumber numberWithDouble:_incomeDetail.unemploymentAmount]];
    [_slices addObject:[NSNumber numberWithDouble:_incomeDetail.basicHousingFundAmount]];

    _pieChart.delegate = self;
    _pieChart.dataSource = self;
    
                       
}

- (void)initValue {    
    _lbAfterTaxIncome.text = [FormatUtils formatCurrency:_incomeDetail.afterTaxIncome];
    _lbTax.text = [FormatUtils formatCurrency:_incomeDetail.tax];
    _lbPension.text = [FormatUtils formatPercent:_incomeDetail.city.iH.pension];
    _lbMedicalCare.text = [FormatUtils formatPercent:_incomeDetail.city.iH.medicalCare];
    _lbUnemployment.text = [FormatUtils formatPercent:_incomeDetail.city.iH.unemployment];
    _lbBasicHousingFund.text = [FormatUtils formatPercent:_incomeDetail.city.iH.basicHousingFund];
    
    _lbPensionAmount.text = [FormatUtils formatCurrency:_incomeDetail.pensionAmount];
    _lbMedicalCareAmount.text = [FormatUtils formatCurrency:_incomeDetail.medicalCareAmount];
    _lbUnemploymentAmount.text = [FormatUtils formatCurrency:_incomeDetail.unemploymentAmount];
    _lbBasicHousingFundAmount.text = [FormatUtils formatCurrency:_incomeDetail.basicHousingFundAmount];
    _lbTaxableAmount.text = [FormatUtils formatCurrency:_incomeDetail.taxableAmount];
    _lbTotalAmount.text = [FormatUtils formatCurrency:_incomeDetail.totalAmount];
    
    [_lbInfo setTitle:((WebSite *)[_incomeDetail.city.websites objectAtIndex:0]).name forState:UIControlStateNormal];
    [_lbInfo addTarget:self action:@selector(presentWebViewController:) forControlEvents:UIControlEventTouchUpInside];

    [_lbInfo2 setTitle:((WebSite *)[_incomeDetail.city.websites objectAtIndex:1]).name forState:UIControlStateNormal];
    [_lbInfo2 addTarget:self action:@selector(presentWebViewController:) forControlEvents:UIControlEventTouchUpInside];

    [self initPieChart];

}

- (void)presentWebViewController:(UIButton *)sender {
    NSURL *url;
    if (sender.tag == 1) {
        url = [NSURL URLWithString:((WebSite *)[_incomeDetail.city.websites objectAtIndex:0]).url];
    } else {
        url = [NSURL URLWithString:((WebSite *)[_incomeDetail.city.websites objectAtIndex:1]).url];
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
        _roundLabel.text = @"养老";
    } else if (1 == index) {
        _roundLabel.text = @"医疗";
    } else if (2 == index) {
        _roundLabel.text = @"失业";
    } else if (3 == index) {
        _roundLabel.text = @"住房";
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
    NSLog(@"%u", result);
    [self dismissModalViewControllerAnimated:YES];
}

- (void)presentActionSheet {    
    [_actionSheet showInView:self.view];
}

- (NSString *)generateInfo {    
    return [NSString stringWithFormat:@"所在城市: %@\n税前收入: %@\n税后收入: %@\n计税金额: %@\n个人所得税: %@",
            _incomeDetail.city.name,
            [FormatUtils formatCurrency:_incomeDetail.preTaxIncome],
            [FormatUtils formatCurrency:_incomeDetail.afterTaxIncome],
            [FormatUtils formatCurrency:_incomeDetail.taxableAmount],
            [FormatUtils formatCurrency:_incomeDetail.tax]];
}

- (void)viewDidUnload {
    self.lbAfterTaxIncome = nil;
    self.lbTax = nil;
    self.lbPension = nil;
    self.lbMedicalCare = nil;
    self.lbUnemployment = nil;
    self.lbBasicHousingFund = nil;
    self.lbPensionAmount = nil;
    self.lbMedicalCareAmount = nil;
    self.lbUnemploymentAmount = nil;
    self.lbBasicHousingFundAmount = nil;
    self.lbTaxableAmount = nil;
    self.lbTotalAmount = nil;
    self.scrollView = nil;
    self.pieChart = nil;
    self.roundLabel = nil;
    self.lbInfo = nil;
    self.lbInfo2 = nil;
    self.actionSheet = nil;
    
    self.incomeDetail = nil;
    self.slices = nil;
    self.sliceColors = nil;
    
    [super viewDidUnload];
}

@end
