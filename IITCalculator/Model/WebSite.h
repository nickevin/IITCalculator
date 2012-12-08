//
//  WebSiteURL.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-10-11.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebSite : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;

- (id)initWithName:(NSString *)name url:(NSString *)url;

@end
