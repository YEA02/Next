//
//  LoginViewController.m
//  Next
//
//  Created by csdc-iMac on 2018/10/12.
//  Copyright © 2018年 K. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage imageNamed:@"123.png"];
    imageView.frame=CGRectMake(160, 120, 100, 100);
    //initWithFrame控制位置和尺寸
    [self.view addSubview:imageView];
    //把imageView加到视图中
    
    UILabel *userLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 280, 90, 50)];
    userLabel.text=@"用户名：";
    [self.view addSubview:userLabel];
    
    UITextField *userField=[[UITextField alloc]init];
    userField.frame=CGRectMake(130, 280, 210, 40);
    userField.borderStyle = UITextBorderStyleRoundedRect;
    userField.layer.borderColor=[UIColor brownColor].CGColor;
    userField.placeholder=@"username"; //水印提示
    userField.layer.borderWidth=1;
    userField.layer.cornerRadius=5;
    [self.view addSubview:userField];
    
    UILabel *passLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 350, 90, 50)];
    passLabel.text=@"密   码：";
    [self.view addSubview:passLabel];
    
    UITextField *passwordField=[[UITextField alloc]init];
    passwordField.frame=CGRectMake(130, 350, 210, 40);
    passwordField.borderStyle = UITextBorderStyleRoundedRect; //设置边框样式
    passwordField.secureTextEntry=YES;  //输入的字符变成*号
    passwordField.clearButtonMode=UITextFieldViewModeAlways;  //有“X”键可以清空文本
    passwordField.layer.borderColor=[UIColor brownColor].CGColor;
    passwordField.layer.borderWidth=1;
    passwordField.layer.cornerRadius=5;
    [self.view addSubview:passwordField];
    
    UIButton *but=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame=CGRectMake(110, 450, 210, 60);
    [but setTitle:@"确认" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(jumpToNext) forControlEvents:UIControlEventTouchUpInside];
    //按键跳转事件，self指代自身。selector（）里面写的是跳转方法,即跳转到jumpToNext()方法。监听“点击事件”，所以是UIControlEventTouchUpInside
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    but.backgroundColor=[UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0];
    //alpha：透明度
    but.titleLabel.font=[UIFont systemFontOfSize:18];//设置按键的字体大小
    [self.view addSubview:but];
    // Do any additional setup after loading the view.
}

- (void)jumpToNext{
    AppDelegate *myAppDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [myAppDelegate changeToInit];  //跳转到主页面
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
