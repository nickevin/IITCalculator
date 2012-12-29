//
//  SettingsView.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-12-26.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}


- (void)initUI {
    [self initCustomizeListUI];
    [self initSectionListUI];
}

- (void)initCustomizeListUI {
    _listCustomize = [[ZenListView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(25, 18, 120, 20)];
    title.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:20.0f];
    title.text = @"自定义";
    title.backgroundColor = [UIColor clearColor];
    title.textColor = RGB(104, 114, 121);
    
    UILabel *pmuTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, title.frame.origin.y
                                                                  + 60, 120, 20)];
    pmuTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    pmuTitle.text = @"五险汇缴基数";
    pmuTitle.backgroundColor = [UIColor clearColor];
    pmuTitle.textColor = RGB(104, 114, 121);
    
    _tfPMU = [[ZenTextField alloc] initWithFrame:CGRectMake(185, pmuTitle.frame.origin.y - 5, 100, 28)];
    [_tfPMU setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    _tfPMU.textColor = RGB(104, 114, 121);
    _tfPMU.backgroundColor = [UIColor clearColor];
    _tfPMU.textAlignment = UITextAlignmentRight;
    
    UIImage *divider = [UIImage imageNamed:@"GenericSeparator"];
    UIImageView *dividerView = [[UIImageView alloc] initWithFrame:CGRectMake(25, pmuTitle.frame.origin.y + 30, 270, 2)];
    dividerView.image = divider;
    
    UILabel *housingFundTitle = [[UILabel alloc] initWithFrame:CGRectMake(35, pmuTitle.frame.origin.y + pmuTitle.frame.size.height + 25, 120, 20)];
    housingFundTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    housingFundTitle.text = @"公积金汇缴基数";
    housingFundTitle.backgroundColor = [UIColor clearColor];
    housingFundTitle.textColor = RGB(104, 114, 121);
    
    _tfHousingFund = [[ZenTextField alloc] initWithFrame:CGRectMake(185, housingFundTitle.frame.origin.y - 5, 100, 28)];
    [_tfHousingFund setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]];
    _tfHousingFund.textColor = RGB(104, 114, 121);
    _tfHousingFund.backgroundColor = [UIColor clearColor];
    _tfHousingFund.textAlignment = UITextAlignmentRight;
    
    [_listCustomize addSubview:title];
    
    [_listCustomize addSubview:pmuTitle];
    [_listCustomize addSubview:_tfPMU];
    [_listCustomize addSubview:dividerView];
    
    [_listCustomize addSubview:housingFundTitle];
    [_listCustomize addSubview:_tfHousingFund];
    
    [self addSubview:_listCustomize];
}

- (void)initSectionListUI {
    _listSection = [[ZenListView alloc] initWithFrame:CGRectMake(0,  _listCustomize.frame.origin.y + _listCustomize.frame.size.height - 30, 320, 215)];
    
    _btnTaxSheet = [UIFactory createLinkButtonWithFrame:CGRectMake(30, 78, 250, 20)];
    _btnTaxSheet.titleLabel.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    [_btnTaxSheet setTitleColor:RGB(104, 114, 121) forState:UIControlStateNormal];
    _btnTaxSheet.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btnTaxSheet setTitle:@"税率表" forState:UIControlStateNormal];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(275, _btnTaxSheet.frame.origin.y + 3, 9, 14)];
    imgView.image = [UIImage imageNamed:@"DetailItemArrow"];
    
    UIImageView *dividerView = [[UIImageView alloc] initWithFrame:CGRectMake(25, _btnTaxSheet.frame.origin.y + 30, 270, 2)];
    dividerView.image = [UIImage imageNamed:@"GenericSeparator"];
    
    _btnFeedback = [UIFactory createLinkButtonWithFrame:CGRectMake(30, _btnTaxSheet.frame.origin.y + _btnTaxSheet.frame.size.height + 25, 250, 20)];
    _btnFeedback.titleLabel.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    [_btnFeedback setTitleColor:RGB(104, 114, 121) forState:UIControlStateNormal];
    _btnFeedback.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btnFeedback setTitle:@"意见反馈" forState:UIControlStateNormal];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(275, _btnFeedback.frame.origin.y + 3, 9, 14)];
    imgView2.image = [UIImage imageNamed:@"DetailItemArrow"];
    
    UIImageView *dividerView2 = [[UIImageView alloc] initWithFrame:CGRectMake(25, _btnFeedback.frame.origin.y + 30, 270, 2)];
    dividerView2.image = [UIImage imageNamed:@"GenericSeparator"];
    
    _btnAbout = [UIFactory createLinkButtonWithFrame:CGRectMake(30, _btnFeedback.frame.origin.y + _btnFeedback.frame.size.height + 25, 250, 20)];
    _btnAbout.titleLabel.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
    [_btnAbout setTitleColor:RGB(104, 114, 121) forState:UIControlStateNormal];
    _btnAbout.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_btnAbout setTitle:@"关于我们" forState:UIControlStateNormal];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(275, _btnAbout.frame.origin.y + 3, 9, 14)];
    imgView3.image = [UIImage imageNamed:@"DetailItemArrow"];
    
    [_listSection addSubview:_btnTaxSheet];
    [_listSection addSubview:imgView];
    [_listSection addSubview:dividerView];
    
    [_listSection addSubview:_btnFeedback];
    [_listSection addSubview:imgView2];
    [_listSection addSubview:dividerView2];
    
    [_listSection addSubview:_btnAbout];
    [_listSection addSubview:imgView3];
    
    [self addSubview:_listSection];
}

@end
