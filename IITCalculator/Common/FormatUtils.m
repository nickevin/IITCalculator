//
//  FormatUtils.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-27.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "FormatUtils.h"

@implementation FormatUtils

+ (NSString *)formatCurrency:(double)num {
    NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
    [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
//    [numFmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [numFmt setCurrencySymbol:@""];
    
    return [numFmt stringFromNumber:[NSNumber numberWithDouble:num]];
}

+ (double)formatDoubleWithCurrency:(NSString *)currency {
    NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
    [numFmt setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numFmt setCurrencySymbol:@""];

    return [[numFmt numberFromString:currency] doubleValue];
}

+ (NSString *)formatPercent:(double)num {
    NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
    [numFmt setNumberStyle:NSNumberFormatterPercentStyle];
    [numFmt setMinimumFractionDigits:1];
    
    return [numFmt stringFromNumber:[NSNumber numberWithDouble:num]];
}

+ (double)formatDoubleWithPercent:(NSString *)percent {
    NSNumberFormatter *numFmt = [[NSNumberFormatter alloc] init];
    [numFmt setNumberStyle:NSNumberFormatterPercentStyle];
    
    return [[numFmt numberFromString:percent]doubleValue];
}



@end
