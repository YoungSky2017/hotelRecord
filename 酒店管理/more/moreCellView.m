//
//  moreCellView.m
//  酒店管理
//
//  Created by 杨奇 on 2019/9/20.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import "moreCellView.h"

#define ViewHeight 70
#define imageViewWH 25
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@interface moreCellView()

@property(nonatomic, strong, readwrite)UIView *ViewAll;
@property(nonatomic, strong, readwrite)UILabel *rightLabel;

@end

@implementation moreCellView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (ViewHeight-imageViewWH)/2, imageViewWH, imageViewWH)];
            _leftImageView;
        })];
        
        [self addSubview:({
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+imageViewWH+20, (ViewHeight-imageViewWH)/2, 100, imageViewWH)];
            _titleLabel;
        })];
        
        [self addSubview:({
            _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60, (ViewHeight-imageViewWH)/2, imageViewWH, imageViewWH)];
            UIImage *img = [UIImage imageNamed:@"右箭头@3x.png"];
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            textAttachment.image = img;
            NSAttributedString *strA = [NSAttributedString attributedStringWithAttachment:textAttachment];
            _rightLabel.attributedText = strA;
            _rightLabel;
        })];
    }
    return self;
}

@end
