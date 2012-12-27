//
//  FormatUtils.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-27.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "FormatUtils.h"

@interface FormatUtils ()

@property (nonatomic, strong) NSNumberFormatter *numFormatter;

@end

@implementation FormatUtils

+ (FormatUtils *)shared {
    static dispatch_once_t once;
    static FormatUtils *shared;
    dispatch_once(&once, ^ {
        shared = [[FormatUtils alloc] init];
    });
    
    return shared;
}

- (NSNumberFormatter *)numFormatter {
    if (_numFormatter == nil) {
        _numFormatter = [[NSNumberFormatter alloc] init];
    }
    
    return _numFormatter;
}

+ (NSString *)formatCurrency:(double)num {
    return [[FormatUtils shared] formatFromNumber:num formatterStyle:NSNumberFormatterCurrencyStyle];
}

+ (NSString *)formatPercent:(double)num {
    return [[FormatUtils shared] formatFromNumber:num formatterStyle:NSNumberFormatterPercentStyle];
}

+ (double)formatDoubleWithCurrency:(NSString *)currency {
    return [[FormatUtils shared] formatFromString:currency formatterStyle:NSNumberFormatterCurrencyStyle];
}

+ (double)formatDoubleWithPercent:(NSString *)percent {    
    return [[FormatUtils shared] formatFromString:percent formatterStyle:NSNumberFormatterPercentStyle];
}

- (NSString *)formatFromNumber:(double)num formatterStyle:(NSNumberFormatterStyle)style{
    if (style == NSNumberFormatterCurrencyStyle) {
        [self.numFormatter setNumberStyle:style];
        //    [_numFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [self.numFormatter setCurrencySymbol:@""];
    } else if (style == NSNumberFormatterPercentStyle) {
        [self.numFormatter setNumberStyle:style];
        [self.numFormatter setMinimumFractionDigits:1];
    }
        
    return [self.numFormatter stringFromNumber:[NSNumber numberWithDouble:num]];
}

- (double)formatFromString:(NSString *)string formatterStyle:(NSNumberFormatterStyle)style{
    if (style == NSNumberFormatterCurrencyStyle) {
        [self.numFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [self.numFormatter setCurrencySymbol:@""];
    } else if (style == NSNumberFormatterPercentStyle) {
        [self.numFormatter setNumberStyle:style];
    }
    
    return [[self.numFormatter numberFromString:string]doubleValue];
}

@end
