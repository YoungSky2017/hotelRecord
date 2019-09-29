//
//  homeViewCard.h
//  酒店管理
//
//  Created by 杨奇 on 2019/9/23.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeViewCard : UIView

@property (nonatomic, strong, readwrite)UILabel *leftTitle;
@property (nonatomic, strong, readwrite)UIImageView *icon;
@property (nonatomic, strong, readwrite)UILabel *titleLabel;
@property (nonatomic, strong, readwrite)UIButton *loadMoreBtn;
@property (nonatomic, strong, readwrite)UILabel *IDLabel;
@property (nonatomic, strong, readwrite)UILabel *hotelLabel;
@property (nonatomic, strong, readwrite)UILabel *timeLabel;
@property (nonatomic, strong, readwrite)UILabel *roomLabel;
@property (nonatomic, strong, readwrite)UILabel *countLabel;
@property (nonatomic, strong, readwrite)UILabel *daysLabel;
@property (nonatomic, strong, readwrite)UILabel *priceLabel;

@end

NS_ASSUME_NONNULL_END
