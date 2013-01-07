//
//  AboutController.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-10-12.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self initValue];
}

- (void)initUI {
    self.title = @"关于我们";
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTexture"]]];
    
    UIImage *icon = [UIImage imageNamed:@"IconAbout"];
    _imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, icon.size.width, icon.size.height)];
    _imgIcon.center = CGPointMake(self.view.center.x, 100);
    _imgIcon.image = icon;
    
    _lbVersion = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 20)];
    [_lbVersion setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:FONT_SIZE_LARGE]];
    _lbVersion.textColor = RGB(104, 114, 121);
    _lbVersion.shadowColor = [UIColor whiteColor];
    _lbVersion.shadowOffset = CGSizeMake(0, 1);
    _lbVersion.backgroundColor = [UIColor clearColor];
    _lbVersion.center = CGPointMake(self.view.center.x, _imgIcon.frame.origin.y + _imgIcon.frame.size.height + 20);

    [self.view addSubview:_imgIcon];
    [self.view addSubview:_lbVersion];
}

- (void)initValue {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString *build = [infoDict objectForKey:@"CFBundleVersion"];
    _lbVersion.text = [NSString stringWithFormat:@"版本: V%@(%@)", version, build];
}

- (void)viewDidUnload {
    [self _viewDidUnload];
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (self.isViewLoaded && !self.view.window) {
        [self _viewDidUnload];
    }
}

- (void)_viewDidUnload {
    [self setImgIcon:nil];
    [self setLbVersion:nil];
}

@end
