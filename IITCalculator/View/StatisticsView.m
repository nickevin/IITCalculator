//
//  StatisticsView.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-12-10.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "StatisticsView.h"

@implementation StatisticsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initPieChartUI];
        [self initPMUUI];
        [self initIncomeTaxUI];
        [self initInfoUI];
    }
    
    return self;
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
    _roundLabel.text = @"总计";
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
    
    [self addSubview:pieChartBackgroundView];
    [self addSubview:_pieChart];
    [self addSubview:_roundLabel];
}

- (void)initPMUUI {
    _listPMU = [[ZenListView alloc] initWithFrame:CGRectMake(0, _pieChart.frame.origin.y + _pieChart.frame.size.height + 10, 320, 390)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 280, 20)];
    title.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:20.0f];
    title.text = @"五险一金汇缴明细";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = RGB(104, 114, 121);
    
    UILabel *pensionTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, title.frame.origin.y + 60, 90, 20)];
    pensionTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    pensionTitle.text = @"养老保险金";
    pensionTitle.backgroundColor = [UIColor clearColor];
    pensionTitle.textColor = RGB(104, 114, 121);
    
    UILabel *parentheses = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width - 2, pensionTitle.frame.origin.y - 1, 100, 20)];
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
    
    UILabel *parentheses2 = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width - 2, medicalCareTitle.frame.origin.y - 1, 100, 20)];
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
    
    UILabel *parentheses3 = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width - 2, unemploymentTitle.frame.origin.y - 1, 100, 20)];
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
    
    UILabel *industrialInjuryTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, unemploymentTitle.frame.origin.y + unemploymentTitle.frame.size.height + 25, 90, 20)];
    industrialInjuryTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    industrialInjuryTitle.text = @"工伤保险金";
    industrialInjuryTitle.backgroundColor = [UIColor clearColor];
    industrialInjuryTitle.textColor = RGB(104, 114, 121);

    UILabel *parentheses4 = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width - 2, industrialInjuryTitle.frame.origin.y - 1, 100, 20)];
    parentheses4.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    parentheses4.textColor = RGB(104, 114, 121);
    parentheses4.backgroundColor = [UIColor clearColor];
    parentheses4.text = @"(            )";
    
    _lbIndustrialInjury = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, unemploymentTitle.frame.origin.y + 45, 60, 20)];
    _lbIndustrialInjury.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbIndustrialInjury.textColor = RGB(104, 114, 121);
    _lbIndustrialInjury.backgroundColor = [UIColor clearColor];
    _lbIndustrialInjury.textAlignment = UITextAlignmentCenter;
    
    _lbIndustrialInjuryAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, unemploymentTitle.frame.origin.y + 45, 100, 20)];
    _lbIndustrialInjuryAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbIndustrialInjuryAmount.textColor = RGB(104, 114, 121);
    _lbIndustrialInjuryAmount.backgroundColor = [UIColor clearColor];
    _lbIndustrialInjuryAmount.textAlignment = UITextAlignmentRight;
        
    UIImageView *dividerView4 = [[UIImageView alloc] initWithFrame:CGRectMake(25, dividerView3.frame.origin.y
                                                                              + 45, 270, 2)];
    dividerView4.image = divider;
    
    UILabel *pregnancyTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, industrialInjuryTitle.frame.origin.y + industrialInjuryTitle.frame.size.height + 25, 90, 20)];
    pregnancyTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    pregnancyTitle.text = @"生育保险金";
    pregnancyTitle.backgroundColor = [UIColor clearColor];
    pregnancyTitle.textColor = RGB(104, 114, 121);
    
    UILabel *parentheses5 = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width - 2, pregnancyTitle.frame.origin.y - 1, 100, 20)];
    parentheses5.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    parentheses5.textColor = RGB(104, 114, 121);
    parentheses5.backgroundColor = [UIColor clearColor];
    parentheses5.text = @"(            )";
    
    _lbPregnancy = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width, pregnancyTitle.frame.origin.y, 60, 20)];
    _lbPregnancy.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbPregnancy.textColor = RGB(104, 114, 121);
    _lbPregnancy.backgroundColor = [UIColor clearColor];
    _lbPregnancy.textAlignment = UITextAlignmentCenter;
    
    _lbPregnancyAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, pregnancyTitle.frame.origin.y, 100, 20)];
    _lbPregnancyAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbPregnancyAmount.textColor = RGB(104, 114, 121);
    _lbPregnancyAmount.backgroundColor = [UIColor clearColor];
    _lbPregnancyAmount.textAlignment = UITextAlignmentRight;

    UIImageView *dividerView5 = [[UIImageView alloc] initWithFrame:CGRectMake(25, dividerView4.frame.origin.y
                                                                              + 45, 270, 2)];
    dividerView5.image = divider;
    
    UILabel *basicHousingFundTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, pregnancyTitle.frame.origin.y + pregnancyTitle.frame.size.height + 25, 90, 20)];
    basicHousingFundTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    basicHousingFundTitle.text = @"住房公积金";
    basicHousingFundTitle.backgroundColor = [UIColor clearColor];
    basicHousingFundTitle.textColor = RGB(104, 114, 121);
    
    UILabel *parentheses6 = [[UILabel alloc] initWithFrame:CGRectMake(pensionTitle.frame.origin.x + pensionTitle.frame.size.width - 2, basicHousingFundTitle.frame.origin.y - 1, 100, 20)];
    parentheses6.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    parentheses6.textColor = RGB(104, 114, 121);
    parentheses6.backgroundColor = [UIColor clearColor];
    parentheses6.text = @"(            )";
    
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
    
    UIImageView *dividerView6 = [[UIImageView alloc] initWithFrame:CGRectMake(25, dividerView5.frame.origin.y
                                                                              + 45, 270, 2)];
    dividerView6.image = divider;
    
    UILabel *totalTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, basicHousingFundTitle.frame.origin.y + basicHousingFundTitle.frame.size.height + 25, 90, 20)];
    totalTitle.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:18.0f];
    totalTitle.text = @"总计";
    totalTitle.backgroundColor = [UIColor clearColor];
    totalTitle.textColor = RGB(104, 114, 121);
    
    _lbTotalAmount = [[UILabel alloc] initWithFrame:CGRectMake(185, totalTitle.frame.origin.y, 100, 20)];
    _lbTotalAmount.font = [UIFont systemFontOfSize:FONT_SIZE_LARGE];
    _lbTotalAmount.textColor = RGB(104, 114, 121);
    _lbTotalAmount.backgroundColor = [UIColor clearColor];
    _lbTotalAmount.textAlignment = UITextAlignmentRight;
    
    [_listPMU addSubview:title];
    [_listPMU addSubview:pensionTitle]; [_listPMU addSubview:parentheses]; [_listPMU addSubview:_lbPension]; [_listPMU addSubview:_lbPensionAmount];
    [_listPMU addSubview:dividerView];
    
    [_listPMU addSubview:medicalCareTitle]; [_listPMU addSubview:parentheses2]; [_listPMU addSubview:_lbMedicalCare]; [_listPMU addSubview:_lbMedicalCareAmount];
    [_listPMU addSubview:dividerView2];
    
    [_listPMU addSubview:unemploymentTitle]; [_listPMU addSubview:parentheses3]; [_listPMU addSubview:_lbUnemployment]; [_listPMU addSubview:_lbUnemploymentAmount];
    [_listPMU addSubview:dividerView3];
    
    [_listPMU addSubview:industrialInjuryTitle]; [_listPMU addSubview:parentheses4]; [_listPMU addSubview:_lbIndustrialInjury]; [_listPMU addSubview:_lbIndustrialInjuryAmount];
    [_listPMU addSubview:dividerView4];
    
    [_listPMU addSubview:pregnancyTitle]; [_listPMU addSubview:parentheses5]; [_listPMU addSubview:_lbPregnancy]; [_listPMU addSubview:_lbPregnancyAmount];
    [_listPMU addSubview:dividerView5];
    
    [_listPMU addSubview:basicHousingFundTitle]; [_listPMU addSubview:parentheses6]; [_listPMU addSubview:_lbBasicHousingFund]; [_listPMU addSubview:_lbBasicHousingFundAmount];
    [_listPMU addSubview:dividerView6];
    
    [_listPMU addSubview:totalTitle]; [_listPMU addSubview:_lbTotalAmount];
    
    [self addSubview:_listPMU];
}

- (void)initIncomeTaxUI {
    _listIncomeTax = [[ZenListView alloc] initWithFrame:CGRectMake(0, _listPMU.frame.origin.y + _listPMU.frame.size.height + 1, 320, 210)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 280, 20)];
    title.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:20.0f];
    title.text = @"个人纳税明细";
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
    
    [_listIncomeTax addSubview:title];
    [_listIncomeTax addSubview:taxableTitle]; [_listIncomeTax addSubview:_lbTaxableAmount];
    [_listIncomeTax addSubview:dividerView2];
    [_listIncomeTax addSubview:taxTitle]; [_listIncomeTax addSubview:_lbTax];
    [_listIncomeTax addSubview:dividerView];
    [_listIncomeTax addSubview:afterTaxIncomeTitle]; [_listIncomeTax addSubview:_lbAfterTaxIncome];
    
    [self addSubview:_listIncomeTax];
}

- (void)initInfoUI {
    _listInfo = [[ZenListView alloc] initWithFrame:CGRectMake(0, _listIncomeTax.frame.origin.y + _listIncomeTax.frame.size.height + 1, 320, 160)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 15, 280, 20)];
    title.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:20.0f];
    title.text = @"相关政策";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = RGB(104, 114, 121);
    
    _lbInfo = [UIFactory createLinkButtonWithFrame:CGRectMake(30, title.frame.origin.y + 60, 250, 20)];
    _lbInfo.titleLabel.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    [_lbInfo setTitleColor:RGB(104, 114, 121) forState:UIControlStateNormal];
    _lbInfo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIButton *btnChevron = [UIFactory createButtonWithFrame:CGRectMake(275, title.frame.origin.y + 62, 9, 14)
                                           normalBackground:[UIImage imageNamed:@"DetailItemArrow"]
                                      highlightedBackground:nil];
    
    UIImage *divider = [UIImage imageNamed:@"GenericSeparator"];
    UIImageView *dividerView = [[UIImageView alloc] initWithFrame:CGRectMake(25, _lbInfo.frame.origin.y + 30, 270, 2)];
    dividerView.image = divider;
    
    _lbInfo2 = [UIFactory createLinkButtonWithFrame:CGRectMake(30, _lbInfo.frame.origin.y + _lbInfo.frame.size.height + 25, 280, 20)];
    _lbInfo2.titleLabel.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    [_lbInfo2 setTitleColor:RGB(104, 114, 121) forState:UIControlStateNormal];
    _lbInfo2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIButton *btnChevron2 = [UIFactory createButtonWithFrame:CGRectMake(275, _lbInfo.frame.origin.y + _lbInfo.frame.size.height + 27, 9, 14) normalBackground:[UIImage imageNamed:@"DetailItemArrow"] highlightedBackground:nil];
    
    [_listInfo addSubview:title];
    [_listInfo addSubview:_lbInfo];
    [_listInfo addSubview:btnChevron];
    [_listInfo addSubview:dividerView];
    [_listInfo addSubview:_lbInfo2];
    [_listInfo addSubview:btnChevron2];
    [self addSubview:_listInfo];
}

@end

