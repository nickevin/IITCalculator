//
//  TaxRateSheet.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "TaxRateSheet.h"

@implementation TaxRateSheet

- (id)init {
    if (self = [super init]) {
        return self;
    }
    
    return nil;
}

- (id)initWithTaxRate:(double)taxRate
            deduction:(double)deduction {
    if (self = [self init]) {
        _taxRate = taxRate;
        _deduction = deduction;
    }
    
    return self;
}

+ (TaxRateSheet *)initWithTaxableAmount:(double)amount {
    if (amount <= 1500) {
        return [[TaxRateSheet alloc]initWithTaxRate:0.03 deduction:0];
    } else if (amount > 1500 && amount <= 4500) {
        return [[TaxRateSheet alloc]initWithTaxRate:0.1 deduction:105];
    } else if (amount > 4500 && amount <= 9000) {
        return [[TaxRateSheet alloc]initWithTaxRate:0.2 deduction:555];
    } else if (amount > 9000 && amount <= 35000) {
        return [[TaxRateSheet alloc]initWithTaxRate:0.25 deduction:1005];
    } else if (amount > 35000 && amount <= 55000) {
        return [[TaxRateSheet alloc]initWithTaxRate:0.3 deduction:2755];
    } else if (amount > 55000 && amount <= 80000) {
        return [[TaxRateSheet alloc]initWithTaxRate:0.35 deduction:5505];
    } else if (amount > 80000) {
        return [[TaxRateSheet alloc]initWithTaxRate:0.45 deduction:13505];
    }
    
    return [[TaxRateSheet alloc]init];
}

@end
