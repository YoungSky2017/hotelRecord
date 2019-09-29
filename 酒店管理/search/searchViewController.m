//
//  searchViewController.m
//  酒店管理
//
//  Created by 杨奇 on 2019/9/19.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import "searchViewController.h"
#import <BmobSDK/Bmob.h>
#import "homeViewCard.h"

#define ZFColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define imageHW ([[UIScreen mainScreen] bounds].size.width) / 7
#define searchImage ([[UIScreen mainScreen] bounds].size.height) / 2
#define labelHeight 30
#define labelWidth 80
#define imageViewWH 25
#define ViewHeight 70


@interface searchViewController ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite)homeViewCard *homeView;
@property (nonatomic, strong, readwrite)UIImageView *imageViewOne;
@property (nonatomic, strong, readwrite)UIImageView *imageViewTwo;
@property (nonatomic, strong, readwrite)UIImageView *imageViewThree;
@property (nonatomic, strong, readwrite)UILabel *titleLabelOne;
@property (nonatomic, strong, readwrite)UILabel *titleLabelTwo;
@property (nonatomic, strong, readwrite)UILabel *titleLabelThree;
@property (nonatomic, strong, readwrite)UIImageView *imageView;
@property (nonatomic, strong, readwrite)UITextField *textField;

@end

@implementation searchViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = ZFColor(204, 204, 204);
        //使坐标原点从(0,64)变成(0,0)开始
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, ViewHeight)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    [self.view addSubview:view];
    
    [view addSubview:({
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (ViewHeight-imageViewWH)/2, imageViewWH, imageViewWH)];
        _imageView.image = [UIImage imageNamed:@"小搜索@2x.png"];
        _imageView;
    })];
    
    [view addSubview:({
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20+imageViewWH+20, (ViewHeight-imageViewWH)/2, SCREEN_WIDTH - imageViewWH - 80, imageViewWH)];
        _textField.placeholder = @"这里输入待查询的姓名";
        //设置键盘代理事件
        _textField.delegate = self;
        //设置键盘return键为搜索按钮
        _textField.returnKeyType = UIReturnKeySearch;
        _textField;
    })];
    
    UIView *viewPic = [[UIView alloc] initWithFrame:CGRectMake(0, 20 + ViewHeight + 20, SCREEN_WIDTH, SCREEN_HEIGHT - ViewHeight - 80)];
    viewPic.backgroundColor = ZFColor(204, 204, 204);
    [self.view addSubview:viewPic];

    _imageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 70) / 2, ViewHeight , imageHW, imageHW)];
    _imageViewOne.image = [UIImage imageNamed:@"查询(2)@3x.png"];
    [viewPic addSubview:_imageViewOne];

    _titleLabelOne = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80) / 2, ViewHeight + imageHW + 10, labelWidth, labelHeight)];
    _titleLabelOne.text = @"极速查询";
    [_titleLabelOne sizeToFit];
    [viewPic addSubview:_titleLabelOne];
    
    _imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 70) / 2, ViewHeight * 2.5 , imageHW, imageHW)];
    _imageViewTwo.image = [UIImage imageNamed:@"真实@3x.png"];
    [viewPic addSubview:_imageViewTwo];

    _titleLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80) / 2, ViewHeight * 2 + imageHW * 2 ,labelWidth, labelHeight)];
    _titleLabelTwo.text = @"真实有效";
    [_titleLabelTwo sizeToFit];
    [viewPic addSubview:_titleLabelTwo];
    
    _imageViewThree = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 70) / 2, ViewHeight * 4 , imageHW, imageHW)];
    _imageViewThree.image = [UIImage imageNamed:@"隐私@3x.png"];
    [viewPic addSubview:_imageViewThree];

    _titleLabelThree = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80) / 2, ViewHeight * 3 + imageHW * 3-30, labelWidth, labelHeight)];
    _titleLabelThree.text = @"安全私密";
    [_titleLabelThree sizeToFit];
    [viewPic addSubview:_titleLabelThree];
}

//收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 150)];
    BmobQuery *bQuery = [BmobQuery queryWithClassName:@"hotel3"];
    [bQuery whereKey:@"name" equalTo:textField.text];
    BmobQuery *main = [BmobQuery queryWithClassName:@"hotel3"];
    //这两句都要有才能进行匹配查询
    [main add:bQuery];
    [main andOperation];
    [main findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //设置scrollView内容范围，即是其滚动范围
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 320 * array.count);
        scrollView.backgroundColor = ZFColor(204, 204, 204);
            NSArray *arr = [NSArray arrayWithArray:array];
        for (int i = 0; i < arr.count; i ++) {
            self->_homeView = [[homeViewCard alloc] initWithFrame:CGRectMake(10, 20 + 290 * i, SCREEN_WIDTH - 20, 270)];
            self->_homeView.backgroundColor = [UIColor whiteColor];
            self->_homeView.layer.cornerRadius = 5;
            self->_homeView.layer.masksToBounds = YES;
            self->_homeView.titleLabel.text = [arr[i] objectForKey:@"name"];
            self->_homeView.IDLabel.text = [arr[i] objectForKey:@"identityID"];
            self->_homeView.hotelLabel.text = [arr[i] objectForKey:@"hotel"];
            self->_homeView.timeLabel.text = [arr[i] objectForKey:@"time"];
            self->_homeView.roomLabel.text = [arr[i] objectForKey:@"roomNumber"];
            self->_homeView.countLabel.text = [arr[i] objectForKey:@"people"];
            self->_homeView.daysLabel.text = [arr[i] objectForKey:@"day"];
            self->_homeView.priceLabel.text = [arr[i] objectForKey:@"price"];
            [scrollView addSubview:self->_homeView];
        }
        [self.view addSubview:scrollView];
    }];
    [textField resignFirstResponder];
    return YES;
}

@end
