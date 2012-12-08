//
//  IH.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "IH.h"

@implementation IH

- (id)init {
    if (self = [super init]) {
        return self;
    }
    
    return nil;
}

- (id)initWithPension:(double)pension
          medicalCare:(double)medicalCare
         unemployment:(double)unemployment
     industrialInjury:(double)industrialInjury
            pregnancy:(double)pregnancy
     basicHousingFund:(double)basicHousingFund {
    if (self = [self init]) {
        _pension = pension;
        _medicalCare = medicalCare;
        _unemployment = unemployment;
        _industrialInjury = industrialInjury;
        _pregnancy = pregnancy;
        _basicHousingFund = basicHousingFund;
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"养老保险金: %f%%, 医疗保险金: %f%%, 失业保险金: %f%%, 工伤保险金: %f%%, 生育保险金: %f%%, 基本住房公积金: %f%%",
            _pension * 100, _medicalCare * 100, _unemployment * 100, _industrialInjury * 100, _pregnancy * 100, _basicHousingFund * 100];
}

@end
