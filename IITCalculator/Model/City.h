//
//  City.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Range.h"
#import "IH.h"
#import "WebSite.h"

@interface City : NSObject <MKAnnotation>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate; // 经纬度
@property (nonatomic, strong) Range *rangePMU; // 三金汇缴基数
@property (nonatomic, strong) Range *rangeH; // 公积金汇缴基数
@property (nonatomic, strong) IH *iH; // 五险一金(个人)
@property (nonatomic, strong) IH *iHEnterprise; // 五险一金(企业)
@property (nonatomic, strong) NSArray *info;

- (id)initWithName:(NSString *)name region:(NSString *)region coordinate:(CLLocationCoordinate2D)coordinate;

@end
