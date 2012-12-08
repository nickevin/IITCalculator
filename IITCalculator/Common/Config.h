//
//  Config.h
//  Zhihu
//
//  Created by Kevin Nick on 2012-10-28.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#ifndef SysLog
#if DEBUG
#define SysLog(fmt, ...) NSLog((@"%s [Line: %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define SysLog(fmt, ...)
#define NSLog(fmt, ...)
#endif
#endif

#define RGB(r, g, b)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kThreshold                       3500
#define kMaxNumber                       999999

#define kProductName                     @"IITCalculator"
#define kCoreDataDBName                  @"IITCalculator.sqlite"
#define kCoreDataEntity_History          @"History"

#define FONT_SIZE_SMALL 12.0f
#define FONT_SIZE_NORMAL 14.0f
#define FONT_SIZE_MEDIUM 15.0f
#define FONT_SIZE_LARGE 16.0f

#define HEITI_SC_LIGHT @"STHeitiSC-Light"
#define HEITI_SC_MEDIUM @"STHeitiSC-Medium"

#define FONT_SIZE_NORMAL_HEIGHT 16.0f
#define FONT_SIZE_MEDIUM_HEIGHT 17.0f
