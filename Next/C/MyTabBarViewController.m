//
//  MyTabBarViewController.m
//  Next
//
//  Created by csdc-iMac on 2018/9/19.
//  Copyright © 2018年 K. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "ViewController.h"
#import "MyViewController.h"
#import "TwoViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    ViewController *v1=[[ViewController alloc]init];
    v1.tabBarItem.title=@"首页";
    v1.tabBarItem.image=[UIImage imageNamed:@"1"];
    UINavigationController *firstNav=[[UINavigationController alloc]initWithRootViewController:v1];
    [self addChildViewController:firstNav];
    
    TwoViewController *v2=[[TwoViewController alloc]init];
    v2.tabBarItem.title=@"发现";
    v2.tabBarItem.image=[UIImage imageNamed:@"3"];
//    UINavigationController *SecondNav=[[UINavigationController alloc]initWithRootViewController:v2];
//    [self addChildViewController:SecondNav];
    [self addChildViewController:v2];
    
    MyViewController *v3=[[MyViewController alloc]init];
    v3.tabBarItem.title=@"我";
    v3.tabBarItem.image=[UIImage imageNamed:@"4"];
    UINavigationController *ThirdNav=[[UINavigationController alloc]initWithRootViewController:v3];
    [self addChildViewController:ThirdNav];  //初次进入程序，title不能显示?？要再点回来才可以
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
