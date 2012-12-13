//
//  Statistics.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "Statistics.h"

@implementation Statistics

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
     pensionAmount:(double)pensionAmount
 medicalCareAmount:(double)medicalCareAmount
unemploymentAmount:(double)unemploymentAmount
industrialInjuryAmount:(double)industrialInjuryAmount
   pregnancyAmount:(double)pregnancyAmount
basicHousingFundAmount:(double)basicHousingFundAmount
       totalAmount:(double)totalAmount {
		if (self = [self init]) {
        _city = city;
        _preTaxIncome = preTaxIncome;
        _afterTaxIncome = afterTaxIncome;
        _taxableAmount = taxableAmount;
        _tax = tax;
        _pensionAmount = pensionAmount;
        _medicalCareAmount = medicalCareAmount;
        _unemploymentAmount = unemploymentAmount;
        _industrialInjuryAmount = industrialInjuryAmount;
        _pregnancyAmount = pregnancyAmount;
        _basicHousingFundAmount = basicHousingFundAmount;
        _totalAmount = totalAmount;
    }
    
    return self; 	 		 	 
}

- (NSString *)description {
    return  [NSString stringWithFormat:@"城市: %@, 税前收入: %f", _city, _preTaxIncome];
}

@end
