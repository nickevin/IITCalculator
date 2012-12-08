//
//  IncomeDetail.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "IncomeDetail.h"

@implementation IncomeDetail

- (id)init {
		if (self = [super init]) {
        return self;
    }
    
    return nil;
}

- (id)initWithCity:(City *)city
      preTaxIncome:(double)preTaxIncome
    afterTaxIncome:(double)afterTaxIncome
     taxableAmount:(double)taxableAmount
               tax:(double)tax
//           pension:(double)pension
//       medicalCare:(double)medicalCare
//      unemployment:(double)unemployment
//  basicHousingFund:(double)basicHousingFund
     pensionAmount:(double)pensionAmount
 medicalCareAmount:(double)medicalCareAmount
unemploymentAmount:(double)unemploymentAmount
basicHousingFundAmount:(double)basicHousingFundAmount
       totalAmount:(double)totalAmount {
		if (self = [self init]) {
        _city = city;
        _preTaxIncome = preTaxIncome;
        _afterTaxIncome = afterTaxIncome;
        _taxableAmount = taxableAmount;
        _tax = tax;
//        _pension = pension;
//        _medicalCare = medicalCare;
//        _unemployment = unemployment;
//        _basicHousingFund = basicHousingFund;
        _pensionAmount = pensionAmount;
        _medicalCareAmount = medicalCareAmount;
        _unemploymentAmount = unemploymentAmount;
        _basicHousingFundAmount = basicHousingFundAmount;
        _totalAmount = totalAmount;
    }
    
    return self; 	 		 	 
}

- (NSString *)description {
    return  [NSString stringWithFormat:@"城市: %@, 税前收入: %f", _city, _preTaxIncome];
}

@end
