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
#import "History.h"

@implementation IITCalculator {
    
    AppDelegate *appDelegate;
    NSManagedObjectContext *managedObjectContext;
}

- (id)init {
    if (self = [super init]) {
        _config = [[NSMutableDictionary alloc]init];
        
        [self initConfig];
        
        appDelegate = [[UIApplication sharedApplication] delegate];
        managedObjectContext = appDelegate.managedObjectContext;
        
        return self;
    }
    
    return nil;
}

- (IncomeDetail *)calc:(double)preTaxIncome
                  city:(NSString *)name
             threshold:(double)threshold
                   pmu:(double)pmu
           housingFund:(double)housingFund {
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
        
    if (pmu == -1 || housingFund == -1) {
        if (preTaxIncome <= lowerPMU) {
            incomePMU = lowerPMU;
        } else if (preTaxIncome >= upperPMU) {
            incomePMU = upperPMU;
        }
        
        if (preTaxIncome <= lowerH) {
            incomeH = lowerH;
        } else if (preTaxIncome >= upperH) {
            incomeH = upperH;
        }
    } else { // 自定义缴费基数
        incomePMU = pmu;
        incomeH = housingFund;
    }
    
    IH *ih = city.iH;
    
    double pensionAmount = incomePMU * ih.pension;
    double medicalCareAmount = incomePMU * ih.medicalCare;
    double unemploymentAmount = incomePMU * ih.unemployment;
    double basicHousingFundAmount = incomeH * ih.basicHousingFund;
    double totalAmount = pensionAmount + medicalCareAmount + unemploymentAmount + basicHousingFundAmount;
    
    // 扣除五险一金
    double amountWithoutIH = preTaxIncome - pensionAmount - medicalCareAmount - unemploymentAmount - basicHousingFundAmount;
    SysLog(@"扣除五险一金: %f - %f * (%f + %f + %f) - %f * (%f) = %f", preTaxIncome, incomePMU, ih.pension, ih.medicalCare, ih.unemployment, incomeH, ih.basicHousingFund, amountWithoutIH);
    
    if (amountWithoutIH < threshold) {
        SysLog(@"税后收入: %f", amountWithoutIH);
        SysLog(@"");
                
        IncomeDetail *incomeDetail = [[IncomeDetail alloc]initWithCity:city
                                                          preTaxIncome:preTaxIncome
                                                        afterTaxIncome:amountWithoutIH
                                                         taxableAmount:0
                                                                   tax:0
//                                                               pension:ih.pension
//                                                           medicalCare:ih.medicalCare
//                                                          unemployment:ih.unemployment
//                                                      basicHousingFund:ih.basicHousingFund
                                                         pensionAmount:pensionAmount
                                                     medicalCareAmount:medicalCareAmount
                                                    unemploymentAmount:unemploymentAmount
                                                basicHousingFundAmount:basicHousingFundAmount
                                                           totalAmount:totalAmount];
        
        [self saveHistory:incomeDetail];
        
        return incomeDetail;
    }
    
    // 应税金额: 扣除五险一金 - 起征点
    double taxableAmount = amountWithoutIH - threshold;
    SysLog(@"计税金额: %f - %f = %f", amountWithoutIH, threshold, taxableAmount);
    
    TaxRateSheet *taxRateSheet = [TaxRateSheet initWithTaxableAmount:taxableAmount];
    double taxRate = taxRateSheet.taxRate;
    double deduction = taxRateSheet.deduction;
    
    // 个人所得税
    double tax = taxableAmount * taxRate - deduction;
    SysLog(@"个人所得税: %f * %f - %f = %f", taxableAmount, taxRate, deduction, tax);
    
    // 税后收入
    double afterTaxIncome = amountWithoutIH - tax;
    SysLog(@"税后收入: %f - %f = %f", amountWithoutIH, tax, afterTaxIncome);
    SysLog(@"");
    
    IncomeDetail *incomeDetail = [[IncomeDetail alloc]initWithCity:city
                                                      preTaxIncome:preTaxIncome
                                                    afterTaxIncome:afterTaxIncome
                                                     taxableAmount:taxableAmount
                                                               tax:tax
//                                                           pension:ih.pension
//                                                       medicalCare:ih.medicalCare
//                                                      unemployment:ih.unemployment
//                                                  basicHousingFund:ih.basicHousingFund
                                                     pensionAmount:pensionAmount
                                                 medicalCareAmount:medicalCareAmount
                                                unemploymentAmount:unemploymentAmount
                                            basicHousingFundAmount:basicHousingFundAmount
                                                       totalAmount:totalAmount];
    
    [self saveHistory:incomeDetail];
    
    return incomeDetail;
}

- (void)saveHistory:(IncomeDetail *)incomeDetail {
    History *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:managedObjectContext];
    if (history == nil) {
        SysLog(@"Failed to create the new entity.");
    }
    
    history.preTaxIncome = [NSNumber numberWithDouble:incomeDetail.preTaxIncome];
    history.afterTaxIncome = [NSNumber numberWithDouble:incomeDetail.afterTaxIncome];
    history.tax = [NSNumber numberWithDouble:incomeDetail.tax];
    history.city = incomeDetail.city.name;
    history.createTime = [NSDate date];
    
    [appDelegate saveContext];
}

- (void)initConfig {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSMutableArray *cities = [[NSMutableArray alloc] initWithContentsOfFile:path];
        
    for (NSDictionary *item in cities) {
        NSString *name = [item objectForKey:@"name"];
        NSString *region = [item objectForKey:@"region"];
        double latitude = [[item objectForKey:@"latitude"] doubleValue];
        double longitude = [[item objectForKey:@"longitude"] doubleValue];
        double lowerPMU = [[item objectForKey:@"lowerPMU"] doubleValue];
        double upperPMU = [[item objectForKey:@"upperPMU"] doubleValue];
        double lowerH = [[item objectForKey:@"lowerH"] doubleValue];
        double upperH = [[item objectForKey:@"upperH"] doubleValue];
        double pension = [[item objectForKey:@"pension"] doubleValue];
        double medicalCare = [[item objectForKey:@"medicalCare"] doubleValue];
        double unemployment = [[item objectForKey:@"unemployment"] doubleValue];
        double basicHousingFund = [[item objectForKey:@"basicHousingFund"] doubleValue];
        NSString *websiteName = [item objectForKey:@"websiteName"];
        NSString *websiteURL = [item objectForKey:@"websiteURL"];
        NSString *websiteName2 = [item objectForKey:@"websiteName2"];
        NSString *websiteURL2 = [item objectForKey:@"websiteURL2"];

        City *city = [[City alloc]initWithName:name region:region coordinate:CLLocationCoordinate2DMake(latitude, longitude)];
        city.rangePMU = [[Range alloc]initWithLower:lowerPMU upper:upperPMU];
        city.rangeH = [[Range alloc]initWithLower:lowerH upper:upperH];
        city.iH = [[IH alloc]initWithPension:pension medicalCare:medicalCare unemployment:unemployment industrialInjury:0 pregnancy:0 basicHousingFund:basicHousingFund];
        city.websites = [NSMutableArray arrayWithObjects:
                        [[WebSite alloc]initWithName:websiteName url:websiteURL],
                        [[WebSite alloc]initWithName:websiteName2 url:websiteURL2], nil];
        
        [_config setValue:city forKey:city.name];
    }
}

@end
