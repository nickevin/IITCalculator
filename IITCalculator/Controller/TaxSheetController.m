//
//  TaxSheetController.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-10-13.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "TaxSheetController.h"

@interface TaxSheetController ()

@end

@implementation TaxSheetController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"税率表";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTexture"]];
    
    UIImage *img = [UIImage imageNamed:@"TaxSheet"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    imgView.image = img;
    imgView.center = CGPointMake(self.view.center.x, 200);
    
    [self.view addSubview:imgView];
}

@end
