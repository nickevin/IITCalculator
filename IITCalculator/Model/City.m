//
//  City.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "City.h"

@implementation City

- (id)init {
    if (self = [super init]) {
        return self;
    }
    
    return nil;
}

- (id)initWithName:(NSString *)name
            region:(NSString *)region
        coordinate:(CLLocationCoordinate2D)coordinate {
    if (self = [self init]) {
        _name = name;
        _region = region;
        _coordinate = coordinate;
    }
    
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown";
    else
        return _name;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@""] ;
}

- (NSString *)description {
    return  [NSString stringWithFormat:@"城市: %@, 区域: %@, 纬度: %f, 经度: %f \n三金汇缴基数: %@, \n公积金汇缴基数: %@, \n五险一金: %@", _name, _region, _coordinate.latitude, _coordinate.longitude, _rangePMU, _rangeH, _iH];
}

@end
