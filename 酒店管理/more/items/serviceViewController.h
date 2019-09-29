//
//  serviceViewController.h
//  酒店管理
//
//  Created by 杨奇 on 2019/9/20.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface serviceViewController : UIViewController
@property(nonatomic,strong,readwrite)WKWebView *webView;
@property(nonatomic, strong, readwrite)NSString *urlString;
@end

NS_ASSUME_NONNULL_END
