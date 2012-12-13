//
//  UIFactory.m
//  Zhihu
//
//  Created by Kevin Nick on 2012-10-28.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+ (UIButton *)createLinkButtonWithFrame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
//    button.backgroundColor = RGB(175, 212, 236);
//    button.layer.borderColor = [UIColor clearColor].CGColor;
//    button.layer.borderWidth = 0.0f;
//    button.layer.cornerRadius = 3.0f;
//    button.tintColor = RGB(175, 212, 236);
    button.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
    button.titleLabel.lineBreakMode = UILineBreakModeWordWrap | UILineBreakModeTailTruncation;
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setShadowOffset:CGSizeMake(0, 1)];
    
    return button;
}

+ (UIBarButtonItem *)createBarBackButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"BarBackButtonNormal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    UIImage *buttonPressedImage = [[UIImage imageNamed:@"BarBackButtonPressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    
    CGRect frame = [button frame];
    title = [NSString stringWithFormat:@"  %@", title]; // trick.
    frame.size.width = [title sizeWithFont:[UIFont boldSystemFontOfSize:12.0]].width + 18.0;
    frame.size.height = buttonImage.size.height;
    button.frame = frame;
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"BarButtonNormal"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    UIImage *buttonPressedImage = [[UIImage imageNamed:@"BarButtonPressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
    
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    
    CGRect frame = [button frame];
    frame.size.width = [title sizeWithFont:[UIFont boldSystemFontOfSize:12.0]].width + 30.0;
    frame.size.height = buttonImage.size.height;
    button.frame = frame;
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)createBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [[UIImage imageNamed:@"BarButtonNormal"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    UIImage *buttonPressedImage = [[UIImage imageNamed:@"BarButtonPressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    
    CGRect frame = CGRectZero;
    frame.size.width = image.size.width + 25.0;
    frame.size.height = buttonImage.size.height;
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame normalBackground:(UIImage *)normalBackground highlightedBackground:(UIImage *)highlightedBackground {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    UIFont *font = [UIFont boldSystemFontOfSize:FONT_SIZE_NORMAL];
    [button.titleLabel setFont:font];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:normalBackground forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackground forState:UIControlStateHighlighted];
    
    return button;
}

@end
