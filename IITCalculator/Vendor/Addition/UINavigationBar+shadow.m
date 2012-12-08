//
//  UINavigationBar+shadow.m
//  Zhihu
//
//  Created by Kevin Nick on 2012-10-28.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "UINavigationBar+shadow.h"

@implementation UINavigationBar (shadow)

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    [self applyDefaultStyle];
}

- (void)applyDefaultStyle {
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0, 1);
    self.layer.shadowOpacity = 0.5;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = YES;
}

@end
