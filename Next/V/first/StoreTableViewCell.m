//
//  StoreTableViewCell.m
//  Next
//
//  Created by csdc-iMac on 2018/7/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import "StoreTableViewCell.h"


@implementation StoreTableViewCell

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
    
    self.view=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
    [self.contentView addSubview:self.view];
    
    self.storeNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 20, 300, 20)];
    self.storeNameLabel.font=[UIFont systemFontOfSize:21];
    [self.contentView addSubview:self.storeNameLabel];
    
    
    self.storeDistanceLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 50, 300, 20)];
    self.storeDistanceLabel.font=[UIFont systemFontOfSize:16];
    self.storeDistanceLabel.textColor=[UIColor grayColor];
    [self.contentView addSubview:self.storeDistanceLabel];
    
    
   self.storeDeliveryCostLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 80, 300, 20)];
    self.storeDeliveryCostLabel.font=[UIFont systemFontOfSize:19];
    [self.contentView addSubview:self.storeDeliveryCostLabel];
    
    
}

-(void)setStoreModel:(StoreModel *)storeModel{
    self.view.image=[UIImage imageNamed:storeModel.storePhotoName];
     self.storeNameLabel.text=storeModel.storeName;
        self.storeDistanceLabel.text=storeModel.storeDistance;
        self.storeDeliveryCostLabel.text=storeModel.storeDeliveryCost;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
