//
//  IncomeDetailController.h
//  NZKeyboard
//
//  Created by Kevin Nick on 2012-11-16.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeDetail.h"
#import "ZenListView.h"
#import "XYPieChart.h"

@interface IncomeDetailController : UIViewController <XYPieChartDataSource, XYPieChartDelegate, UIActionSheetDelegate, MFMessageComposeViewControllerDelegate>

// outlets
@property (strong, nonatomic) UILabel *lbAfterTaxIncome; // 税后收入
@property (strong, nonatomic) UILabel *lbTax; // 个税
@property (strong, nonatomic) UILabel *lbPension; // 养老金汇缴费率
@property (strong, nonatomic) UILabel *lbMedicalCare; // 医疗金汇缴费率
@property (strong, nonatomic) UILabel *lbUnemployment; // 失业金汇缴费率
@property (strong, nonatomic) UILabel *lbBasicHousingFund; // 住房公积金汇缴费率
@property (strong, nonatomic) UILabel *lbPensionAmount;
@property (strong, nonatomic) UILabel *lbMedicalCareAmount;
@property (strong, nonatomic) UILabel *lbUnemploymentAmount;
@property (strong, nonatomic) UILabel *lbBasicHousingFundAmount;
@property (strong, nonatomic) UILabel *lbTaxableAmount;
@property (strong, nonatomic) UILabel *lbTotalAmount;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) XYPieChart *pieChart;
@property (strong, nonatomic) UILabel *roundLabel;
@property (strong, nonatomic) UIButton *lbInfo;
@property (strong, nonatomic) UIButton *lbInfo2;
@property (nonatomic, strong) UIActionSheet *actionSheet;

@property (nonatomic, strong) IncomeDetail *incomeDetail;
@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray *sliceColors;

- (id)initWithIncomeDetail:(IncomeDetail *)incomeDetail;


@end
