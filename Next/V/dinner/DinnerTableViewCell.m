//
//  DinnerTableViewCell.m
//  Next
//
//  Created by csdc-iMac on 2018/9/25.
//  Copyright © 2018年 K. All rights reserved.
//

#import "DinnerTableViewCell.h"
#import "UIView+SDAutoLayout.h"

CGFloat maxHeight=0;
@implementation DinnerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self create];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)create{
 
    self.userImg =[[UIImageView alloc]init];
    [self.contentView addSubview:self.userImg];
    
    self.userLabel=[[UILabel alloc]init];
    self.userLabel.font=[UIFont systemFontOfSize:23];
    [self.contentView addSubview:self.userLabel];
    
    self.detailLabel=[[UILabel alloc]init];
    self.detailLabel.font=[UIFont systemFontOfSize:18];
    if(maxHeight==0){
        maxHeight=self.detailLabel.font.lineHeight*3;
    }   //一开始把这句话放在第一行，结果行数没到三行也显示了“查看更多”，因为没赋值成功正确的行高
    [self.contentView addSubview:self.detailLabel];
    
    self.formore=[[UILabel alloc]init];
    self.formore.text=@"查看更多";
    self.formore.textColor=[UIColor grayColor];
    self.formore.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.formore];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(More:)];
    self.formore.userInteractionEnabled=YES;
    [self.formore addGestureRecognizer:tap];
    
    self.phtoContainer=[[PhotoContainer alloc]init];
    [self.contentView addSubview:self.phtoContainer];
    
    self.userImg.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 10)
    .widthIs(50)
    .heightIs(50);
    
    self.userLabel.sd_layout
    .leftSpaceToView(self.userImg, 15)
    .topSpaceToView(self.contentView, 10)
    .widthIs(150)
    .heightIs(25);
    
    self.detailLabel.sd_layout
    .topSpaceToView(self.userLabel, 10)
    .leftEqualToView(self.userLabel)
    .rightSpaceToView(self.contentView, 5)
    .autoHeightRatio(0); //还是要写上这句高度自适应
    
    self.formore.sd_layout
    .topSpaceToView(self.detailLabel, 5)
    .leftEqualToView(self.userLabel)
    .widthIs(100);
    
    self.phtoContainer.sd_layout
    .topSpaceToView(self.formore, 5)
    .leftEqualToView(self.userLabel);
}

-(void)More:(UITapGestureRecognizer *)recognizer{

    [self.delegate didClickForMore:self];
}

-(void)setModel:(DinnerModel *)dinnerModel {
    self.userImg.image=[UIImage imageNamed:dinnerModel.userIconName];
    self.userLabel.text=dinnerModel.userName;
    self.detailLabel.text=dinnerModel.detail;
    self.phtoContainer.statePhotoArray=dinnerModel.PhotoNameArray;
    
    UIView *bottomV;
    
    if(dinnerModel.shouldForMore){
        self.formore.sd_layout
        .heightIs(25);
        self.formore.hidden=NO;
        if(dinnerModel.isOpen){
            self.detailLabel.sd_layout
            .maxHeightIs(MAXFLOAT);  //展开
            self.formore.text=@"收起";
        }else{
            self.detailLabel.sd_layout
            .maxHeightIs(maxHeight);  //收起，最多显示三行
            self.formore.text=@"查看更多";
        }
        if(dinnerModel.PhotoNameArray.count){
           
            bottomV=self.phtoContainer;
        }else{
            bottomV=self.formore;
        }
    }else{
        self.formore.sd_layout
        .heightIs(0);
        self.detailLabel.sd_layout
        .autoHeightRatio(0);
        self.formore.hidden=YES;
        if(dinnerModel.PhotoNameArray.count==0){
            bottomV=self.detailLabel;       
        }else{
            bottomV=self.phtoContainer;
        }
    }
     [self  setupAutoHeightWithBottomView:bottomV bottomMargin:20];  //因为忘记这句，所以布局又乱了
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
