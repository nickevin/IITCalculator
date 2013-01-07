//
//  UIThemeManager.m
//  IITCalculator
//
//  Created by Kevin Nick on 2013-1-4.
//  Copyright (c) 2013年 com.zen. All rights reserved.
//

#import "UIThemeManager.h"

@implementation UIThemeManager

+ (void)customizeAppearance {
    UIImage *navBarBackground = [UIImage imageNamed:@"NavigationBar"];
    [[UINavigationBar appearance] setBackgroundImage:navBarBackground forBarMetrics:UIBarMetricsDefault];
    
    UIImage *barButton = [[UIImage imageNamed:@"BarButtonNormal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    [[UIBarButtonItem appearance] setBackgroundImage:barButton
                                            forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    UIImage *barHighlightedButton = [[UIImage imageNamed:@"BarButtonPressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barHighlightedButton
                                            forState:UIControlStateHighlighted
                                          barMetrics:UIBarMetricsDefault];
    
    UIImage *backButton = [[UIImage imageNamed:@"BarBackButtonNormal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 6)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    UIImage *backHighlightedButton = [[UIImage imageNamed:@"BarBackButtonHighlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 6)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backHighlightedButton
                                                      forState:UIControlStateHighlighted
                                                    barMetrics:UIBarMetricsDefault];
    
    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"ToolBarBottom"]
                            forToolbarPosition:UIToolbarPositionBottom
                                    barMetrics:UIBarMetricsDefault];
}

@end