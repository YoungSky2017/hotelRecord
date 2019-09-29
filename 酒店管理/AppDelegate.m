//
//  AppDelegate.m
//  酒店管理
//
//  Created by 杨奇 on 2019/9/19.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import "AppDelegate.h"
#import "managerViewController.h"
#import "searchViewController.h"
#import "moreViewController.h"
#import <BmobSDK/Bmob.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Bmob registerWithAppKey:@"c38324e6a2ce440a23799b08af99ed6c"];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    managerViewController *manager = [[managerViewController alloc] init];
    manager.navigationItem.title = @"管理中心";
    manager.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"manage" image:nil tag:0];
    
    searchViewController *search = [[searchViewController alloc] init];
    search.navigationItem.title = @"查询";
    search.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"hello22" image:nil tag:1];
    
    moreViewController *more = [[moreViewController alloc] init];
    more.navigationItem.title = @"更多";
    more.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"hello33" image:nil tag:2];

    UINavigationController *navigationController1 = [[UINavigationController alloc] initWithRootViewController:manager];
    navigationController1.tabBarItem.image = [UIImage imageNamed:@"管理点击@2x.png"];
    navigationController1.tabBarItem.title = @"管理";
    
    UINavigationController *navigationController2 = [[UINavigationController alloc] initWithRootViewController:search];
    navigationController2.tabBarItem.title = @"搜索";
    navigationController2.tabBarItem.image = [UIImage imageNamed:@"搜索点击@2x.png"];
    
    UINavigationController *navigationController3 = [[UINavigationController alloc] initWithRootViewController:more];
    navigationController3.tabBarItem.title = @"更多";
    navigationController3.tabBarItem.image = [UIImage imageNamed:@"更多点击@2x.png"];
    
    [tabbarController addChildViewController:navigationController1];
    [tabbarController addChildViewController:navigationController2];
    [tabbarController addChildViewController:navigationController3];
    
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
