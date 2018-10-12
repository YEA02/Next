//
//  ActivityTableViewCell.m
//  Next
//
//  Created by csdc-iMac on 2018/7/20.
//  Copyright © 2018年 K. All rights reserved.
//
#define MAINSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    self.activityImage1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [self.contentView addSubview:_activityImage1];
    
    self.activityImage2=[[UIImageView alloc]initWithFrame:CGRectMake(MAINSCREENWIDTH/2, 10, 50, 50)];
    [self.contentView addSubview:_activityImage2];
    
    self.activityNameLabel1=[[UILabel alloc]initWithFrame:CGRectMake(70, 15, MAINSCREENWIDTH/2-50, 20)];
    self.activityNameLabel1.font=[UIFont systemFontOfSize:21];
    [self.contentView addSubview:_activityNameLabel1];
    
    self.activityNameLabel2=[[UILabel alloc]initWithFrame:CGRectMake(MAINSCREENWIDTH/2+60, 15, MAINSCREENWIDTH/2-50, 20)];
    self.activityNameLabel2.font=[UIFont systemFontOfSize:21];
    [self.contentView addSubview:_activityNameLabel2];
    
    self.activityDetailLabel1=[[UILabel alloc]initWithFrame:CGRectMake(70, 40, MAINSCREENWIDTH/2+50, 20)];
        self.activityDetailLabel1.textColor=[UIColor grayColor];
        self.activityDetailLabel1.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:_activityDetailLabel1];
    
    self.activityDetailLabel2=[[UILabel alloc]initWithFrame:CGRectMake(MAINSCREENWIDTH/2+60, 40, MAINSCREENWIDTH/2-50, 20)];
    self.activityDetailLabel2.textColor=[UIColor grayColor];
        self.activityDetailLabel2.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:_activityDetailLabel2];
}

-(void)setActivityModel:(ActivityModel *)activityModel{
    self.activityImage1.image=[UIImage imageNamed:activityModel.activityPhoto1];
    self.activityImage2.image=[UIImage imageNamed:activityModel.activityPhoto2];
    self.activityNameLabel1.text=activityModel.activityName1;
    self.activityNameLabel2.text=activityModel.activityName2;
    self.activityDetailLabel1.text=activityModel.activityDetail1;
    self.activityDetailLabel2.text=activityModel.activityDetail2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
