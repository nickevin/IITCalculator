//
//  StatisticsView.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-12-10.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsView : UIView

// outlets
@property (strong, nonatomic) XYPieChart *pieChart;
@property (strong, nonatomic) UILabel *roundLabel;

@property (strong, nonatomic) ZenListView *listPMU;
@property (strong, nonatomic) ZenListView *listIncomeTax;
@property (strong, nonatomic) ZenListView *listInfo;

@property (strong, nonatomic) UILabel *lbPension; // 养老金汇缴费率
@property (strong, nonatomic) UILabel *lbMedicalCare; // 医疗金汇缴费率
@property (strong, nonatomic) UILabel *lbUnemployment; // 失业金汇缴费率
@property (strong, nonatomic) UILabel *lbIndustrialInjury; // 工伤汇缴费率
@property (strong, nonatomic) UILabel *lbPregnancy; // 生育汇缴费率
@property (strong, nonatomic) UILabel *lbBasicHousingFund; // 住房公积金汇缴费率

@property (strong, nonatomic) UILabel *lbPensionAmount;
@property (strong, nonatomic) UILabel *lbMedicalCareAmount;
@property (strong, nonatomic) UILabel *lbUnemploymentAmount;
@property (strong, nonatomic) UILabel *lbIndustrialInjuryAmount;
@property (strong, nonatomic) UILabel *lbPregnancyAmount;
@property (strong, nonatomic) UILabel *lbBasicHousingFundAmount;
@property (strong, nonatomic) UILabel *lbTotalAmount;

@property (strong, nonatomic) UILabel *lbAfterTaxIncome; // 税后收入
@property (strong, nonatomic) UILabel *lbTaxableAmount; // 计税金额
@property (strong, nonatomic) UILabel *lbTax; // 个税

@property (strong, nonatomic) UIButton *lbInfo;
@property (strong, nonatomic) UIButton *lbInfo2;

@end
