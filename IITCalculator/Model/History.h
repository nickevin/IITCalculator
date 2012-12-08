//
//  History.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-30.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface History : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSNumber * preTaxIncome;
@property (nonatomic, retain) NSNumber * afterTaxIncome;
@property (nonatomic, retain) NSNumber * tax;
@property (nonatomic, retain) NSDate * createTime;

@end
