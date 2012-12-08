//
//  ZenTextField.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-26.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "ZenTextField.h"

@implementation ZenTextField

- (id)initWithFrame:(CGRect)frame {    
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    UIButton *btnDone = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 47, 37)];
//    [btnDone addTarget:self action:@selector(doneWithNumberPad) forControlEvents:UIControlEventTouchUpInside];
////    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
//    [btnDone setImage:[UIImage imageNamed:@"down-chevron"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSeperator.width = 310 - 47;
//    
//    UIToolbar* toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 37)];
//    toolbar.barStyle = UIBarStyleBlackTranslucent;
//    toolbar.items = [NSArray arrayWithObjects:
////                           [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
//                           negativeSeperator,
//                           [[UIBarButtonItem alloc]initWithCustomView:btnDone],
//                           nil];
////    [toolbar sizeToFit];
//    
//    self.keyboardType = UIKeyboardTypeDecimalPad;
//    self.inputAccessoryView = toolbar;
//}

//- (void)cancelNumberPad {
//    [self resignFirstResponder];
//}
//
//- (void)doneWithNumberPad {
//    if ([self.toolbarDelegate textFieldDidFinishEditing:self]) {
//        [self resignFirstResponder];
//    }
//}

// Disable copy, paste.
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    
    return NO;
}

@end
