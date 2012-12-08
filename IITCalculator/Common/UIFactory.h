//
//  UIFactory.h
//  Zhihu
//
//  Created by Kevin Nick on 2012-10-28.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFactory : NSObject

+ (UIButton *)createLinkButtonWithFrame:(CGRect)frame;

+ (UIBarButtonItem *)createBarBackButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)createBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

+ (UIButton *)createButtonWithFrame:(CGRect)frame normalBackground:(UIImage *)normalBackground highlightedBackground:(UIImage *)highlightedBackground;

@end
