//
//  AppDelegate.m
//  Next
//
//  Created by csdc-iMac on 2018/7/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WelcomeViewController.h"
#import "MyTabBarViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    WelcomeViewController *view=[[WelcomeViewController alloc]init];
    self.window.rootViewController=view;
    [self.window makeKeyAndVisible];
    
//    MyTabBarViewController *vc=[[MyTabBarViewController alloc]init];
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
//    self.window.rootViewController=nav;
//    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

-(void)changeToLogin{   //回到登录页面
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
    
}

-(void)changeToInit{   //回到主页面
    MyTabBarViewController *vc=[[MyTabBarViewController alloc]init];
    //    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];  //错误
    //    self.window.rootViewController=nav;
    self.window.rootViewController=vc;
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
