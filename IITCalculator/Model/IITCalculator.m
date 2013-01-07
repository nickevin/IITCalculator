//
//  IITCalculator.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "AppDelegate.h"

#import "IITCalculator.h"
#import "Range.h"
#import "IH.h"
#import "City.h"
#import "TaxRateSheet.h"

@implementation IITCalculator {

}

- (id)init {
    if (self = [super init]) {
        _config = [[NSMutableDictionary alloc] initWithCapacity:40];
        
        [self initConfig];

        return self;
    }
    
    return nil;
}

- (Statistics *)calc:(double)preTaxIncome
                  city:(NSString *)name
                  mode:(int)mode {
    City *city = [_config objectForKey:name];    
    NSLog(@"----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----");
    NSLog(@"税前收入: %f, 城市: %@", preTaxIncome, name);
    NSLog(@"----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----");
    NSLog(@"");
    
    double upperPMU = city.rangePMU.upper;
    double lowerPMU = city.rangePMU.lower;
    double upperH = city.rangeH.upper;
    double lowerH = city.rangeH.lower;
    
    double incomePMU = preTaxIncome;
    double incomeH = preTaxIncome;
    
    double threshold = THRESHOLD;
    
    double pmu = 0.00;
    double housingFund = 0.00;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *plistPath = [path stringByAppendingPathComponent:@"user-settings.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSDictionary *map = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        pmu = [[map valueForKey:@"pmu"] doubleValue];
        housingFund = [[map valueForKey:@"housingFund"] doubleValue];
    } else {
        NSMutableDictionary *map =[[NSMutableDictionary alloc]init];
        [map setValue:[NSNumber numberWithDouble:pmu] forKey:@"pmu"];
        [map setValue:[NSNumber numberWithDouble:housingFund] forKey:@"housingFund"];
        [map writeToFile:plistPath atomically:YES];
    }
        
    if (pmu == 0.00) {
        if (preTaxIncome < lowerPMU) {
            incomePMU = lowerPMU;
        } else if (preTaxIncome > upperPMU) {
            incomePMU = upperPMU;
        }
    } else { // 自定义缴费基数
        incomePMU = pmu;
    }
    
    if (housingFund == 0.00) {
        if (preTaxIncome < lowerH) {
            incomeH = lowerH;
        } else if (preTaxIncome > upperH) {
            incomeH = upperH;
        }
    } else { // 自定义缴费基数
        incomeH = housingFund;
    }
        
    IH *ih = nil;
    if (mode == 0) {
        ih = city.iH;
    } else {
        ih = city.iHEnterprise;
    }
    
    double pensionAmount = incomePMU * ih.pension;
    double medicalCareAmount = incomePMU * ih.medicalCare;
    double unemploymentAmount = incomePMU * ih.unemployment;
    double industrialInjuryAmount = incomePMU * ih.industrialInjury;
    double pregnancyAmount = incomePMU * ih.pregnancy;
    double basicHousingFundAmount = incomeH * ih.basicHousingFund;
    double totalAmount = pensionAmount + medicalCareAmount + unemploymentAmount + industrialInjuryAmount + pregnancyAmount + basicHousingFundAmount;
    
    // 扣除五险一金
    double amountWithoutIH = preTaxIncome -  incomePMU * (city.iH.pension + city.iH.medicalCare + city.iH.unemployment + city.iH.industrialInjury + city.iH.industrialInjury + city.iH.pregnancy) - incomeH * city.iH.basicHousingFund;
    NSLog(@"扣除五险一金: %f - %f * (%f + %f + %f + %f + %f) - %f * (%f) = %f", preTaxIncome, incomePMU, city.iH.pension, city.iH.medicalCare, city.iH.unemployment, city.iH.industrialInjury, city.iH.pregnancy, incomeH, ih.basicHousingFund, amountWithoutIH);
    
    if (amountWithoutIH < threshold) {
        NSLog(@"税后收入: %f", amountWithoutIH);
        NSLog(@"");
                
        Statistics *statistics = [[Statistics alloc]initWithCity:city
                                                          preTaxIncome:preTaxIncome
                                                        afterTaxIncome:amountWithoutIH
                                                         taxableAmount:0
                                                                   tax:0
                                                         pensionAmount:pensionAmount
                                                     medicalCareAmount:medicalCareAmount
                                                    unemploymentAmount:unemploymentAmount
                                                industrialInjuryAmount:industrialInjuryAmount
                                                       pregnancyAmount:pregnancyAmount
                                                basicHousingFundAmount:basicHousingFundAmount
                                                           totalAmount:totalAmount];
        
        return statistics;
    }
    
    // 应税金额: 扣除五险一金 - 起征点
    double taxableAmount = amountWithoutIH - threshold;
    NSLog(@"计税金额: %f - %f = %f", amountWithoutIH, threshold, taxableAmount);
    
    TaxRateSheet *taxRateSheet = [TaxRateSheet initWithTaxableAmount:taxableAmount];
    double taxRate = taxRateSheet.taxRate;
    double deduction = taxRateSheet.deduction;
    
    // 个人所得税
    double tax = taxableAmount * taxRate - deduction;
    NSLog(@"个人所得税: %f * %f - %f = %f", taxableAmount, taxRate, deduction, tax);
    
    // 税后收入
    double afterTaxIncome = amountWithoutIH - tax;
    NSLog(@"税后收入: %f - %f = %f", amountWithoutIH, tax, afterTaxIncome);
    NSLog(@"");
    
    Statistics *statistics = [[Statistics alloc]initWithCity:city
                                                      preTaxIncome:preTaxIncome
                                                    afterTaxIncome:afterTaxIncome
                                                     taxableAmount:taxableAmount
                                                               tax:tax
                                                     pensionAmount:pensionAmount
                                                 medicalCareAmount:medicalCareAmount
                                                unemploymentAmount:unemploymentAmount
                                            industrialInjuryAmount:industrialInjuryAmount
                                                   pregnancyAmount:pregnancyAmount
                                            basicHousingFundAmount:basicHousingFundAmount
                                                       totalAmount:totalAmount];
    
    return statistics;
}

- (void)initConfig {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *cities = [[NSArray alloc] initWithContentsOfFile:path];
        
    for (NSDictionary *item in cities) {
        NSString *name = [item objectForKey:@"name"];
        NSString *region = [item objectForKey:@"region"];
        
        NSDictionary *coordinate = (NSDictionary *)[item objectForKey:@"coordinate"];
        double latitude = [[coordinate objectForKey:@"latitude"] doubleValue];
        double longitude = [[coordinate objectForKey:@"longitude"] doubleValue];

        City *city = [[City alloc]initWithName:name
                                        region:region
                                    coordinate:CLLocationCoordinate2DMake(latitude, longitude)];
        
        NSDictionary *range = (NSDictionary *)[item objectForKey:@"range"];
        double lowerPMU = [[range objectForKey:@"lowerPMU"] doubleValue];
        double upperPMU = [[range objectForKey:@"upperPMU"] doubleValue];
        double lowerH = [[range objectForKey:@"lowerH"] doubleValue];
        double upperH = [[range objectForKey:@"upperH"] doubleValue];
        city.rangePMU = [[Range alloc] initWithLower:lowerPMU upper:upperPMU];
        city.rangeH = [[Range alloc] initWithLower:lowerH upper:upperH];
        
        NSDictionary *individual = (NSDictionary *)[item objectForKey:@"individual"];
        city.iH = [[IH alloc] initWithPension:[[individual objectForKey:@"pension"] doubleValue]
                                  medicalCare:[[individual objectForKey:@"medicalCare"] doubleValue]
                                 unemployment:[[individual objectForKey:@"unemployment"] doubleValue]
                             industrialInjury:0
                                    pregnancy:0
                             basicHousingFund:[[individual objectForKey:@"basicHousingFund"] doubleValue]];
                             
        NSDictionary *enterprise = (NSDictionary *)[item objectForKey:@"enterprise"];
        city.iHEnterprise = [[IH alloc] initWithPension:[[enterprise objectForKey:@"pension"] doubleValue]
                                            medicalCare:[[enterprise objectForKey:@"medicalCare"] doubleValue]
                                           unemployment:[[enterprise objectForKey:@"unemployment"] doubleValue]
                                       industrialInjury:[[enterprise objectForKey:@"industrialInjury"] doubleValue]
                                              pregnancy:[[enterprise objectForKey:@"pregnancy"] doubleValue]
                                       basicHousingFund:[[enterprise objectForKey:@"basicHousingFund"] doubleValue]];
        
        NSDictionary *info = (NSDictionary *)[item objectForKey:@"info"];
        city.info = @[[[WebSite alloc] initWithName:[info objectForKey:@"websiteName"]
                                                    url:[info objectForKey:@"websiteURL"]],
                          [[WebSite alloc] initWithName:[info objectForKey:@"websiteName2"]
                                                    url:[info objectForKey:@"websiteURL2"]]];
        
        [_config setValue:city forKey:city.name];
    }
}

@end
