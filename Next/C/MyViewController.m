
//
//  MyViewController.m
//  Next
//
//  Created by csdc-iMac on 2018/9/19.
//  Copyright © 2018年 K. All rights reserved.
//

#import "MyViewController.h"
#import "AppDelegate.h"

@interface MyViewController ()
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *titleArray;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"我";
    self.edgesForExtendedLayout=NO;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.titleArray=[[NSMutableArray alloc]initWithObjects:@"我的收藏",@"我的订单",@"个人设置",@"关于", nil];
    
    
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 90;
    }else{
        return 50;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else if (section==1){
        return self.titleArray.count;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"iden";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    if(indexPath.section==0){
        cell.textLabel.text=@"K";
        cell.imageView.image=[UIImage imageNamed:@"i.jpeg"];
    }else if (indexPath.section==1){
        cell.textLabel.text=self.titleArray[indexPath.row];
    }else{
        cell.textLabel.text=@"退出";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section ==2){
        UIAlertController *action=[UIAlertController alertControllerWithTitle:nil message:@"确认退出?" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *exit=[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self jumpToLogin];  //点击退出登录后，跳转至jumpToLogin方法
        }];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [action addAction:exit];  //为该Action Sheet添加exit按键
        [action addAction:cancel];  //为该Action Sheet添加cancel按键
        [self presentViewController:action animated:YES completion:nil]; //在界面上显示
    }
}

- (void)jumpToLogin{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate changeToLogin];   //跳转到登录页面
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
