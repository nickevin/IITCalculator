//
//  IITCalculator.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statistics.h"

@interface IITCalculator : NSObject

@property (nonatomic, strong) NSDictionary *config;

- (Statistics *)calc:(double)preTaxIncome
                city:(NSString *)name
                mode:(int)mode;

@end
