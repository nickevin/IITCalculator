//
//  ZenTextField.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-26.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZenTextFieldDelegate <UITextFieldDelegate>

- (BOOL)textFieldDidFinishEditing:(UITextField *)textField;

@end

@interface ZenTextField : UITextField

//@property(nonatomic, weak) id<ZenTextFieldDelegate> toolbarDelegate;

@end
