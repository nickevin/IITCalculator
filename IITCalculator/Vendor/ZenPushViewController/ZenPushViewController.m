//
//  ZenPushViewController.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-12-23.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "ZenPushViewController.h"

@interface ZenPushViewController ()

@property (nonatomic, strong) UIView *pushView;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation ZenPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   	[self _initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self _initValue];
}

- (void)_initUI {
    _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _hintLabel.font = [UIFont fontWithName:HEITI_SC_MEDIUM size:FONT_SIZE_NORMAL];
    _hintLabel.textColor = [UIColor lightGrayColor];
    _hintLabel.shadowColor = [UIColor whiteColor];
    _hintLabel.shadowOffset = CGSizeMake(-1, 1);
    _hintLabel.backgroundColor = [UIColor clearColor];
    _hintLabel.center = CGPointMake(300, (self.view.bounds.size.height - 44) / 2);
    _hintLabel.text = @"返回";
    
    UIImage *arrowImage = [UIImage imageNamed:@"ArrowRightIcon"];
    _arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, arrowImage.size.width, arrowImage.size.height)];
    _arrowView.center = CGPointMake(_hintLabel.frame.origin.x - 15, (self.view.bounds.size.height - 44) / 2);
    _arrowView.image = arrowImage;
    
    UIImage *dashedLine = [UIImage imageNamed:@"DashedLine"];
    UIView *dashedLineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - dashedLine.size.width, 0, dashedLine.size.width, self.view.bounds.size.height)];
    dashedLineView.backgroundColor = [[UIColor alloc] initWithPatternImage:dashedLine];
    
    _pushView = [[UIView alloc] initWithFrame:CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _pushView.backgroundColor = RGB(228, 228, 228);
    _pushView.alpha = 0;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:self.panGesture];
    
    [self.view addSubview:_pushView];
    [_pushView addSubview:dashedLineView];
    [_pushView addSubview:_arrowView];
    [_pushView addSubview:_hintLabel];
}

- (void)_initValue {
    self.subDelegate = self;
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)panGesture {
	CGPoint point = [panGesture translationInView:self.navigationController.view];
    
    if (point.y != 0) {
        [self.view endEditing:YES];
    }
        
	if (panGesture.state == UIGestureRecognizerStateBegan) {
        // Do nothing.
	} else if (panGesture.state == UIGestureRecognizerStateChanged) {
		 if (point.x >= 0 && self.navigationController) {
            _pushView.alpha = 100;
            
            //  push-up resistance.
            [self.view setFrame:CGRectMake(point.x / 2.3, 0, self.view.frame.size.width, self.view.frame.size.height)];
            
//            NSLog(@"%f, %f, %f", point.x, _arrowView.frame.origin.x, _hintLabel.frame.origin.x);
            
            if (point.x >= PUSH_VIEW_THRESHOLD) {
                // fix frame.
                _hintLabel.frame = CGRectMake((320 + _hintLabel.frame.size.width) - point.x / 2.3, _hintLabel.frame.origin.y, _hintLabel.frame.size.width, _hintLabel.frame.size.height);
                _arrowView.frame = CGRectMake(_hintLabel.frame.origin.x - 25, _arrowView.frame.origin.y, _arrowView.frame.size.width, _arrowView.frame.size.height);
                                
                [UIView animateWithDuration:0.2 animations:^{
                    _arrowView.transform = CGAffineTransformMakeRotation(M_PI);
                } completion:nil];
                
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    _arrowView.transform = CGAffineTransformMakeRotation(0);
                } completion:nil];
            }
		}
	} else if (panGesture.state == UIGestureRecognizerStateEnded) {
            if (point.x > PUSH_VIEW_THRESHOLD && self.navigationController) {
                [self.subDelegate didPanToPositionX];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                }];
            }
    }
    
}

- (void)didPanToPositionX {
    //    [UIView animateWithDuration:0.15 delay:ANIMATION_DURATION * 2 options:UIViewAnimationCurveEaseOut animations:^{
    //        [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    } completion:^(BOOL finished) {
    //    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
