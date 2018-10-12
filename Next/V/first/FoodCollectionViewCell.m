//
//  FoodCollectionViewCell.m
//  Next
//
//  Created by csdc-iMac on 2018/9/18.
//  Copyright © 2018年 K. All rights reserved.
//

#import "FoodCollectionViewCell.h"

@implementation FoodCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
       
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.foodPhoto=[[UIImageView alloc]initWithFrame:CGRectMake(5, 10, self.frame.size.width-10, 70)];
    [self.contentView addSubview:self.foodPhoto];
    
    self.foodNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(2, _foodPhoto.frame.size.height+20, self.frame.size.width, 20)];  //这个self指的是cell，所以定义宽度self.frame.size.width，即食品名称标签的宽度就是各个cell的宽度。共8个cell
    self.foodNameLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.foodNameLabel];
}

-(void)setModel:(FoodModel *)foodModel{
    self.foodNameLabel.text=foodModel.foodName;
    self.foodPhoto.image=[UIImage imageNamed:foodModel.foodPhotoName];
}

@end
