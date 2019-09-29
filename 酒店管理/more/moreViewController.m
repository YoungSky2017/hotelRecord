//
//  moreViewController.m
//  酒店管理
//
//  Created by 杨奇 on 2019/9/19.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import "moreViewController.h"
#import "moreCellView.h"
#import <WebKit/WebKit.h>
#import "serviceViewController.h"
#import "privacyViewController.h"
#import <QuartzCore/QuartzCore.h>

#define ZFColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define ViewHeight 70

@interface moreViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic, strong, readwrite)UIButton *btn1;
@property(nonatomic, strong, readwrite)WKWebView *webView;

@end

@implementation moreViewController

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
    // Do any additional setup after loading the view.
    moreCellView *moreCellViewClick1 = [[moreCellView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, ViewHeight)];
    moreCellViewClick1.backgroundColor = [UIColor whiteColor];
    moreCellViewClick1.titleLabel.text = @"隐私政策";
    moreCellViewClick1.leftImageView.image = [UIImage imageNamed:@"隐私政策@2x.png"];
    //UIView切割圆角
    moreCellViewClick1.layer.cornerRadius = 5;
    moreCellViewClick1.layer.masksToBounds = YES;
    [self.view addSubview:moreCellViewClick1];
    //隐私政策添加点击事件
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(privacyPolicy)];
    [moreCellViewClick1 addGestureRecognizer:tapGestureRecognizer1];
    moreCellView *moreCellViewClick2 = [[moreCellView alloc] initWithFrame:CGRectMake(10, 20+20+ViewHeight, SCREEN_WIDTH - 20, ViewHeight)];
    moreCellViewClick2.backgroundColor = [UIColor whiteColor];
    moreCellViewClick2.titleLabel.text = @"服务条款";
    moreCellViewClick2.leftImageView.image = [UIImage imageNamed:@"服务条款@2x.png"];
    //UIView切割圆角
    moreCellViewClick2.layer.cornerRadius = 5;
    moreCellViewClick2.layer.masksToBounds = YES;
    [self.view addSubview:moreCellViewClick2];
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceTerms)];
    [moreCellViewClick2 addGestureRecognizer:tapGestureRecognizer2];
}

- (void)privacyPolicy {
    privacyViewController *privacyController = [[privacyViewController alloc] init];
    [self.navigationController pushViewController:privacyController animated:YES];
    privacyController.title = @"隐私协议";
    //    serviceController.urlString = @"https://www.jianshu.com";
    //消除返回按钮文字,此方法是没有复杂需求时使用
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:UIButton.new];
}

- (void)serviceTerms {
    serviceViewController *serviceController = [[serviceViewController alloc] init];
    [self.navigationController pushViewController:serviceController animated:YES];
    serviceController.title = @"服务条款";
    //消除返回按钮文字,此方法是没有复杂需求时使用
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:UIButton.new];
}

@end
