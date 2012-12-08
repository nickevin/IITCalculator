//
//  WebSiteURL.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-10-11.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "WebSite.h"

@implementation WebSite

- (id)init {
    if (self = [super init]) {
        return self;
    }
    
    return nil;
}

- (id)initWithName:(NSString *)name url:(NSString *)url {
    if (self = [self init]) {
        _name = name;
        _url = url;
    }
    
    return self;
}

@end

