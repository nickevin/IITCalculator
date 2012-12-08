//
//  FormatUtils.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-27.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormatUtils : NSObject

+ (NSString *)formatCurrency:(double)num;
+ (double)formatDoubleWithCurrency:(NSString *)currency;

+ (NSString *)formatPercent:(double)num;
+ (double)formatDoubleWithPercent:(NSString *)percent;

@end
