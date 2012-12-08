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
 
    UIImage * backgroundImage = [UIImage imageNamed:@"BackgroundTexture"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
