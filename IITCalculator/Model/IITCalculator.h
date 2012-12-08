//
//  IITCalculator.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IncomeDetail.h"

@interface IITCalculator : NSObject

@property (nonatomic, strong) NSMutableDictionary *config;

- (IncomeDetail *)calc:(double)preTaxIncome
                  city:(NSString *)name
             threshold:(double)threshold
                   pmu:(double)pmu
           housingFund:(double)housingFund;

@end
