//
//  OperationMenu.m
//  Next
//
//  Created by csdc-iMac on 2018/9/21.
//  Copyright © 2018年 K. All rights reserved.
//

#import "OperationMenu.h"
#import "UIView+SDAutoLayout.h"


@implementation OperationMenu

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareBtn setImage:[UIImage imageNamed:@"item-btn-share-black"] forState:UIControlStateNormal];
    [self.shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shareBtn];
    
    self.collectionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectionBtn setImage:[UIImage imageNamed:@"item-btn-like-black"] forState:UIControlStateNormal];
    [self.collectionBtn addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectionBtn];
    
    self.likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setImage:[UIImage imageNamed:@"item-btn-thumb-black"] forState:UIControlStateNormal];
    [self.likeBtn addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.likeBtn];
    
    self.likeNumLabel=[[UILabel alloc]init];
    self.likeNumLabel.text=@"5";
    self.likeNumLabel.textColor=[UIColor lightGrayColor];
    [self addSubview:self.likeNumLabel];
    
    self.commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setImage:[UIImage imageNamed:@"item-btn-comment-black"] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.commentBtn];
    
    self.commentNumLabel=[[UILabel alloc]init];
    self.commentNumLabel.textColor=[UIColor lightGrayColor];
    [self addSubview:self.commentNumLabel];
    
    self.shareBtn.sd_layout
    .leftSpaceToView(self, 2)
    .topSpaceToView(self, 2)
    .widthIs(35)
    .bottomEqualToView(self);
    
    self.collectionBtn.sd_layout
    .leftSpaceToView(self.shareBtn, 15)
    .topSpaceToView(self, 2)
    .widthIs(35)
    .bottomEqualToView(self);
    
    self.likeBtn.sd_layout
    .leftSpaceToView(self.collectionBtn, 15)
    .topSpaceToView(self, 2)
    .widthIs(35)
    .bottomEqualToView(self);
    
    self.likeNumLabel.sd_layout
    .leftSpaceToView(self.likeBtn, 0)
    .topSpaceToView(self, 2)
    .widthIs(15)
    .bottomEqualToView(self);
    
    self.commentBtn.sd_layout
    .leftSpaceToView(self.likeNumLabel, 10)
    .topSpaceToView(self, 2)
    .widthIs(35)
    .bottomEqualToView(self);
    
    self.commentNumLabel.sd_layout
    .leftSpaceToView(self.commentBtn, 0)
    .topSpaceToView(self, 2)
    .widthIs(20)
    .bottomEqualToView(self);
    
    [self setupAutoWidthWithRightView:self.commentNumLabel rightMargin:10];
}

-(void)share{
    [self.delegate didClickShare];
}

-(void)collection:(UIButton *)sender{    //收藏状态
    sender.selected=!sender.selected;   //取反状态
    if(sender.selected==YES){
        [self.collectionBtn setImage:[UIImage imageNamed:@"icon-bookmark-v32"] forState:UIControlStateNormal];
    }else{
        [self.collectionBtn setImage:[UIImage imageNamed:@"item-btn-like-black"] forState:UIControlStateNormal];
    }
}

-(void)like:(UIButton *)sender{   //点赞状态
    sender.selected=!sender.selected;    //取反状态
    int numb=[self.likeNumLabel.text intValue];
    if(sender.selected==YES){    //选中状态
        [self.likeBtn setImage:[UIImage imageNamed:@"icon-zan"] forState:UIControlStateNormal];
        numb=numb+1;
        NSString *num=[NSString stringWithFormat:@"%d",numb];
        self.likeNumLabel.text=num;
    }else{    //取消状态
        [self.likeBtn setImage:[UIImage imageNamed:@"item-btn-thumb-black"] forState:UIControlStateNormal];
        numb=numb-1;
        NSString *num=[NSString stringWithFormat:@"%d",numb];
        self.likeNumLabel.text=num;
    }
}

-(void)comment{
    if(self.commentClick){   //block
        self.commentClick();
    }
}

@end
