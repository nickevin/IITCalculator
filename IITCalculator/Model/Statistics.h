//
//  Statistics.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "City.h"

@interface Statistics : NSObject

@property (nonatomic, strong) City *city;
@property (nonatomic, assign) double preTaxIncome;
@property (nonatomic, assign) double afterTaxIncome;
@property (nonatomic, assign) double taxableAmount;
@property (nonatomic, assign) double tax;
@property (nonatomic, assign) double pensionAmount;
@property (nonatomic, assign) double medicalCareAmount;
@property (nonatomic, assign) double unemploymentAmount;
@property (nonatomic, assign) double industrialInjuryAmount;
@property (nonatomic, assign) double pregnancyAmount;
@property (nonatomic, assign) double basicHousingFundAmount;
@property (nonatomic, assign) double totalAmount;

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
       totalAmount:(double)totalAmount;

@end
