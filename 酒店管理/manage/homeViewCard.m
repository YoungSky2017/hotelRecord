//
//  homeViewCard.m
//  酒店管理
//
//  Created by 杨奇 on 2019/9/23.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import "homeViewCard.h"
#import <BmobSDK/Bmob.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define ViewHeight 50
#define imageViewWH 30
#define toTop 10

@interface homeViewCard()
@property (nonatomic, strong, readwrite)NSArray *titleArray;
@property (nonatomic, strong, readwrite)NSArray *infoArray;
@property (nonatomic, strong, readwrite)NSMutableArray *infoMutableArray;
@end

@implementation homeViewCard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, toTop, imageViewWH, imageViewWH)];
            _icon.image = [UIImage imageNamed:@"默认头像@2x.png"];
            _icon;
        })];
        
        [self addSubview:({
            UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight, SCREEN_WIDTH - 20, 1)];
            horizontal.backgroundColor = [UIColor grayColor];
            horizontal;
        })];
        
        _titleArray = [NSArray arrayWithObjects:@"身份证号码:",@"入住酒店:",@"入住时间:",@"入住房号:",@"入住人数:",@"入住天数:",@"房间单价:", nil];
        [self addSubview:({
            for (int i = 0; i < 7; i ++) {
                _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50 +toTop + 30 * i, 100, 20)];
                _titleLabel.text = _titleArray[i];
                [self addSubview:_titleLabel];
            }
            _titleLabel;
        })];
        
        [self addSubview:({
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, toTop, 100, 30)];
            _titleLabel;
        })];
        
        _infoArray = [NSArray arrayWithObjects:@"_IDLabel",@"_hotelLabel",@"_timeLabel",@"_roomLabel",@"_countLabel",@"_daysLabel",@"_priceLabel", nil];
        [self addSubview:({
            _IDLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50 +toTop + 30 * 0, 210, 20)];
            _IDLabel;
        })];
        
        [self addSubview:({
            _hotelLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50 +toTop + 30 * 1, 200, 20)];
            _hotelLabel;
        })];
        
        [self addSubview:({
            _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50 +toTop + 30 * 2, 200, 20)];
            _timeLabel;
        })];
        
        [self addSubview:({
            _roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50 +toTop + 30 * 3, 200, 20)];
            _roomLabel;
        })];
        
        [self addSubview:({
            _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50 +toTop + 30 * 4, 200, 20)];
            _countLabel;
        })];
        
        [self addSubview:({
            _daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50 +toTop + 30 * 5, 200, 20)];
            _daysLabel;
        })];
        
        [self addSubview:({
            _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50 +toTop + 30 * 6, 200, 20)];
            _priceLabel;
        })];
    }
    return self;
}

@end
