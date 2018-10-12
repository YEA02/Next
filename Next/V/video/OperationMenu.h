//
//  OperationMenu.h
//  Next
//
//  Created by csdc-iMac on 2018/9/21.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "VideoModel.h"

@protocol OperationMenuClick <NSObject>   //声明协议
-(void) didClickShare;
@end


@interface OperationMenu : UIView
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) UILabel *likeNumLabel;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UILabel *commentNumLabel;
@property (nonatomic,weak) id <OperationMenuClick> delegate;

@property (nonatomic,copy) void  (^commentClick)(void);  //block

@end
