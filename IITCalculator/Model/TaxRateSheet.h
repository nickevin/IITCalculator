//
//  TaxRateSheet.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxRateSheet : NSObject

@property (nonatomic, assign) double taxRate; // 税率
@property (nonatomic, assign) double deduction; // 扣除数

+ (TaxRateSheet *)initWithTaxableAmount:(double)amount;

@end
