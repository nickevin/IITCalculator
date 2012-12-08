//
//  Range.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-24.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Range : NSObject

@property (nonatomic, assign) double upper;
@property (nonatomic, assign) double lower;

- (id)initWithLower:(double)upper upper:(double)lower;
- (BOOL)withinRange:(double)number;

@end
