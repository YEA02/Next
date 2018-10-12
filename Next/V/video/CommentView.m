//
//  CommentView.m
//  Next
//
//  Created by csdc-iMac on 2018/9/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import "CommentView.h"
#import "UIView+SDAutoLayout.h"

@implementation CommentView
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self createUI];
        self.commentItemsArray=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)createUI{
    self.backGroundIV=[[UIImageView alloc]init];
    self.backGroundIV.image=[[[UIImage imageNamed:@"LikeCmtBg"]stretchableImageWithLeftCapWidth:40 topCapHeight:30]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.backGroundIV.backgroundColor=[UIColor clearColor];
    [self addSubview:self.backGroundIV];
    
    self.backGroundIV.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)setCommentArray:(NSArray *)commentArray{   //重写set方法
    _commentArray=commentArray;
    long originalLabelsCount=self.commentItemsArray.count; //初始评论数
    long needsToAddCount=commentArray.count > originalLabelsCount? (commentArray.count-originalLabelsCount):0;  //新增的评论数量
    
    //添加label
    for(int i=0;i<needsToAddCount;i++){
        UILabel *label=[[UILabel alloc]init];
        [self addSubview:label];
        [self.commentItemsArray addObject:label];
    }
    
    //为label赋值
    for(int i=0;i<commentArray.count;i++){
        CommentModel *commentModel=commentArray[i];   //取出model
        UILabel *label=self.commentItemsArray[i];
    if(commentModel.attributedContent==nil)
        label.attributedText=[self generateAttributedStringWithCommentItemModel:commentModel];   //根据评论model为label赋值
    }  
}

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(CommentModel *)commentModel{
        NSString *tex=commentModel.commentA;
        if(commentModel.commentB.length){
            tex=[tex stringByAppendingString:[NSString  stringWithFormat:@"回复%@",commentModel.commentB]];  // A 回复 B
        }
        tex=[tex stringByAppendingString:[NSString  stringWithFormat: @": %@",commentModel.commentDetail]];  // A 回复 B ：----
        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:tex];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[tex rangeOfString:commentModel.commentA]];
        if(commentModel.commentB){
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[tex rangeOfString:commentModel.commentB]];
        }  //修改部分字体颜色
    return str;
}


-(void)setCommentView:(NSArray *)commentModelArray{
    self.commentArray=commentModelArray;   //self.commentArray=  调用- (void)setCommentArray:(NSArray *)commentArray方法实现赋值
  
    if(self.commentItemsArray.count){
        [self.commentItemsArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *  stop) {
            [label sd_clearAutoLayoutSettings];  //重用时先隐藏所有的评论label
            label.hidden=YES;
        }];
    }
    if(self.commentArray.count==0){
        self.fixedWidth=@(0);  //固定宽度
        self.fixedHeight=@(0); //固定高度
        return;
    }else{
        self.fixedHeight=nil;  //取消固定高度
        self.fixedWidth=nil;   //取消固定宽度
    }
    UIView *lastTopView=nil;
    
    for(int i=0;i<self.commentArray.count;i++){
            
        UILabel *label=(UILabel *)self.commentItemsArray[i];   //取出前面已经赋值过的label
        label.hidden=NO;
        label.sd_layout
        .leftEqualToView(self)
        .rightSpaceToView(self, 2)
        .topSpaceToView(lastTopView, 1)   // 每个label相对于上一个label设置距离
        .autoHeightRatio(0);
        label.isAttributedContent=YES;
        lastTopView=label;
        //为每一个评论label加上手势识别
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addComment:)];
        label.userInteractionEnabled=YES;
        [label addGestureRecognizer:tap];
        label.tag=i;
    }
    
    [self setupAutoHeightWithBottomView:lastTopView bottomMargin:6];
}

-(void)addComment:(UITapGestureRecognizer *)sender{
    CommentModel *model=self.commentArray[sender.view.tag];   //获取点击的当前label所在model
    NSString *commentTo=model.commentA;
    [self.delegate commentClick:commentTo];  //delegate传递model的commentA参数
}

@end
