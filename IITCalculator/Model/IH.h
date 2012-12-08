//
//  IH(Insurance and Housing Fund)
//
//  <ul>
//      <li>Insurance: Pension, Medical Care, Unemployment, Industrial Injury, Pregnancy </li>
//      <li>Housing Fund: Basic, Additional</li>
//  </ul>
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IH : NSObject

@property (nonatomic, assign) double pension;
@property (nonatomic, assign) double medicalCare;
@property (nonatomic, assign) double unemployment;
@property (nonatomic, assign) double industrialInjury;
@property (nonatomic, assign) double pregnancy;
@property (nonatomic, assign) double basicHousingFund;

- (id)initWithPension:(double)pension
          medicalCare:(double)medicalCare
         unemployment:(double)unemployment
     industrialInjury:(double)industrialInjury
            pregnancy:(double)pregnancy
     basicHousingFund:(double)basicHousingFund;

@end
