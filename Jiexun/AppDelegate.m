//
//  AppDelegate.m
//  Jiexun
//
//  Created by skma on 16/1/26.
//  Copyright © 2016年 jiexun. All rights reserved.
//

#import "AppDelegate.h"
#import "InformationViewController.h"
#import "ProductViewController.h"
#import "MineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    // 资讯
    InformationViewController *IFVC = [[InformationViewController alloc]init];
    IFVC.title = @"资讯";
    IFVC.tabBarItem.image = [UIImage imageNamed:@"zixun"];
    UINavigationController *IFNAVC = [[UINavigationController alloc]initWithRootViewController:IFVC];
    
    // 产品
    ProductViewController *PDVC = [[ProductViewController alloc]init];
    PDVC.title = @"产品";
    PDVC.tabBarItem.image = [UIImage imageNamed:@"chanpin"];
    UINavigationController *NAPDVC = [[UINavigationController alloc]initWithRootViewController:PDVC];
    
    // 我的
    MineViewController *MEVC = [[MineViewController alloc]init];
    MEVC.title = @"我的";
    MEVC.tabBarItem.image = [UIImage imageNamed:@"wode"];
    UINavigationController *NAMEVC = [[UINavigationController alloc]initWithRootViewController:MEVC];
    
    //
    NSArray *array = @[IFNAVC, NAPDVC, NAMEVC];
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.viewControllers = array;
    //
    _window.rootViewController = tabBarController;
    [_window makeKeyAndVisible];    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
