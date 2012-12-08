//
//  Range.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "Range.h"

@implementation Range

- (id)init {
    if (self = [super init]) {
        return self;
    }
    
    return nil;
}

- (id)initWithLower:(double)lower upper:(double)upper {
    if (self = [self init]) {
        _lower = lower;
        _upper = upper;
    }
    
    return self;
}

- (BOOL)withinRange:(double)number {
    return number >= _lower && number <= _upper;
}

- (NSString *)description {
    return  [NSString stringWithFormat:@"上限: %f, 下限: %f", _upper, _lower];
}

@end
