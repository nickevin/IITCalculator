//
//  HistoryCell.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-30.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _lbCity = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 120, 30)];
        _lbCity.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:30.0f];
        _lbCity.backgroundColor = [UIColor clearColor];
        _lbCity.textColor = RGB(104, 114, 121);
//        _lbCity.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

        UILabel *preTaxIncomeTitle = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, 80, 30)];
        preTaxIncomeTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
        preTaxIncomeTitle.text = @"税前收入: ";
        preTaxIncomeTitle.backgroundColor = [UIColor clearColor];
        preTaxIncomeTitle.textColor = RGB(104, 114, 121);
        preTaxIncomeTitle.textAlignment = UITextAlignmentRight;

        _lbPreTaxIncome = [[UILabel alloc] initWithFrame:CGRectMake(210, 10, 100, 30)];
        _lbPreTaxIncome.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:FONT_SIZE_LARGE];
        _lbPreTaxIncome.backgroundColor = [UIColor clearColor];
        _lbPreTaxIncome.textColor = RGB(104, 114, 121);
        _lbPreTaxIncome.textAlignment = UITextAlignmentRight;
        
        UILabel *afterTaxIncomeTitle = [[UILabel alloc] initWithFrame:CGRectMake(preTaxIncomeTitle.frame.origin.x, preTaxIncomeTitle.frame.origin.y + 30, 80, 30)];
        afterTaxIncomeTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
        afterTaxIncomeTitle.text = @"税后收入: ";
        afterTaxIncomeTitle.backgroundColor = [UIColor clearColor];
        afterTaxIncomeTitle.textColor = RGB(104, 114, 121);
        afterTaxIncomeTitle.textAlignment = UITextAlignmentRight;
        
        _lbAfterTaxIncome = [[UILabel alloc] initWithFrame:CGRectMake(210, preTaxIncomeTitle.frame.origin.y + 30, 100, 30)];
        _lbAfterTaxIncome.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:FONT_SIZE_LARGE];
        _lbAfterTaxIncome.backgroundColor = [UIColor clearColor];
        _lbAfterTaxIncome.textColor = RGB(104, 114, 121);
        _lbAfterTaxIncome.textAlignment = UITextAlignmentRight;
        
        UILabel *taxTitle = [[UILabel alloc] initWithFrame:CGRectMake(preTaxIncomeTitle.frame.origin.x, afterTaxIncomeTitle.frame.origin.y + 30, 80, 30)];
        taxTitle.font = [UIFont fontWithName:HEITI_SC_LIGHT size:FONT_SIZE_LARGE];
        taxTitle.text = @"缴纳个税: ";
        taxTitle.backgroundColor = [UIColor clearColor];
        taxTitle.textColor = RGB(104, 114, 121);
        taxTitle.textAlignment = UITextAlignmentRight;
        
        _lbTax = [[UILabel alloc] initWithFrame:CGRectMake(210, afterTaxIncomeTitle.frame.origin.y + 30, 100, 30)];
        _lbTax.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:FONT_SIZE_LARGE];
        _lbTax.backgroundColor = [UIColor clearColor];
        _lbTax.textColor = RGB(104, 114, 121);
        _lbTax.textAlignment = UITextAlignmentRight;
        
//        UIImage *separator = [UIImage imageNamed:@"GenericSeparator"];
//        UIImageView *separatorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 2)];
//        separatorView.image = separator;

        [self.contentView addSubview:_lbCity];
        [self.contentView addSubview:preTaxIncomeTitle];
        [self.contentView addSubview:_lbPreTaxIncome];
        [self.contentView addSubview:afterTaxIncomeTitle];
        [self.contentView addSubview:_lbAfterTaxIncome];
        [self.contentView addSubview:taxTitle];
        [self.contentView addSubview:_lbTax];
//        [self.contentView addSubview:separatorView];
    }
    
    return self;
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
