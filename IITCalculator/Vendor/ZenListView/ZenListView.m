//
//  ZenListView.m
//  NZKeyboard
//
//  Created by Kevin Nick on 2012-11-17.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "ZenListView.h"

@implementation ZenListView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *separatorLine = [UIImage imageNamed:@"ListSeparatorLine"];
        UIImageView *separatorLineView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, separatorLine.size.width, separatorLine.size.height)];
        separatorLineView.image = separatorLine;
        
        UIImage *listTop = [UIImage imageNamed:@"ListTop"];
        UIImageView *listTopView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - listTop.size.width) / 2, frame.origin.y + 15, listTop.size.width, listTop.size.height)];
        listTopView.image = listTop;
        
        UIImage *listBackground = [UIImage imageNamed:@"ListBackground"];
        UIImageView *listBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - listBackground.size.width) / 2, listTopView.frame.origin.y + 6, listBackground.size.width, frame.size.height)];
        listBackgroundView.backgroundColor = [UIColor colorWithPatternImage:listBackground];
        
        UIImage *listBottom = [UIImage imageNamed:@"ListBottom"];
        UIImageView *listBottomView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - listBottom.size.width) / 2, listBackgroundView.frame.size.height + listBackgroundView.frame.origin.y, listBottom.size.width, listBottom.size.height)];
        listBottomView.image = listBottom;
                
        [self addSubview:separatorLineView];
        [self addSubview:listTopView];
        [self addSubview:listBackgroundView];
        [self addSubview:listBottomView];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
