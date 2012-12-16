//
//  HistoryCell.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-30.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_HEIGHT     100

@interface HistoryCell : UITableViewCell

@property (strong, nonatomic) UILabel *lbCity;
@property (strong, nonatomic) UILabel *lbPreTaxIncome;
@property (strong, nonatomic) UILabel *lbAfterTaxIncome;
@property (strong, nonatomic) UILabel *lbTax;

@end
