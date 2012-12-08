//
//  IncomeDetail.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "City.h"

@interface IncomeDetail : NSObject

@property (nonatomic, strong) City *city;
@property (nonatomic, assign) double preTaxIncome;
@property (nonatomic, assign) double afterTaxIncome;
@property (nonatomic, assign) double taxableAmount;
@property (nonatomic, assign) double tax;
//@property (nonatomic, assign) double pension;
//@property (nonatomic, assign) double medicalCare;
//@property (nonatomic, assign) double unemployment;
//@property (nonatomic, assign) double basicHousingFund;
@property (nonatomic, assign) double pensionAmount;
@property (nonatomic, assign) double medicalCareAmount;
@property (nonatomic, assign) double unemploymentAmount;
@property (nonatomic, assign) double basicHousingFundAmount;
@property (nonatomic, assign) double totalAmount;

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
       totalAmount:(double)totalAmount;

@end
