//
//  VideoTableViewCell.m
//  Next
//
//  Created by csdc-iMac on 2018/9/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#define KCompressibilityFactor 1280.00

@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self createUI];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)createUI{
    self.photoImg=[[UIImageView alloc]init];
    [self.contentView addSubview:self.photoImg];
    
    self.nameLabel=[[UILabel alloc]init];
    self.nameLabel.font=[UIFont systemFontOfSize:24];
    [self.contentView addSubview:self.nameLabel];
    
    self.detailLabel=[[UILabel alloc]init];
    self.detailLabel.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.detailLabel];
    
    __weak typeof (self)weakSelf=self;
    self.operationMenu=[[OperationMenu alloc]init];
    [self.contentView addSubview:self.operationMenu];
    self.operationMenu.delegate=self;
    [self.operationMenu setCommentClick:^{
        if([weakSelf.delegate respondsToSelector:@selector(didClickComment:)]){
            [weakSelf.delegate didClickComment:weakSelf];  //调用协议的方法，传递参数值weakSelf
        }
    }];
    
    self.commentView=[[CommentView alloc]init];
    [self.contentView addSubview:self.commentView];
    self.commentView.delegate=self;
    
    self.photoImg.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 15)
    .heightIs(160);
    
    self.nameLabel.sd_layout
    .widthIs(150)
    .leftEqualToView(self.photoImg)
    .topSpaceToView(self.photoImg, 15)
    .heightIs(20);
    
    self.detailLabel.sd_layout
    .widthRatioToView(self.photoImg, 1)
    .leftEqualToView(self.photoImg)
    .topSpaceToView(self.nameLabel, 20)
    .autoHeightRatio(0);
    
    self.operationMenu.sd_layout
    .leftEqualToView(self.photoImg)
    .topSpaceToView(self.detailLabel, 10)
    .heightIs(45);
    
    self.commentView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(self.operationMenu, 0);

    [self setupAutoHeightWithBottomView:self.commentView bottomMargin:20];
    
}

-(void)setModel:(VideoModel *) videoModel{
    
    self.photoImg.image=[UIImage imageNamed:videoModel.photoName];
    self.nameLabel.text=videoModel.Name;
    self.detailLabel.text=videoModel.detail;
    self.operationMenu.commentNumLabel.text=[NSString stringWithFormat:@"%lu", (unsigned long)videoModel.commentModelArray.count];  //评论数由commentModelArray的数目决定
    [self.commentView setCommentView:videoModel.commentModelArray];
}

-(void)commentClick:(NSString *)string{
    self.isReplying=YES;
    [self.delegate didComment:self andString:string];
}

-(void)didClickShare{
    //文字加图片分享
    NSString *textToShare = self.detailLabel.text;
    UIImage *imageToShare=[self getJPEGImagerImg:self.photoImg.image];  //压缩图片
//    UIImage *imageToShare = [UIImage imageNamed:@"btn-share-link"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        // 排除（UIActivityTypeAirDrop）AirDrop 共享、(UIActivityTypePostToFacebook)Facebook
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypeAirDrop];
  
    [self.delegate didShare:activityVC];
    
}

#pragma mark - 压缩一张图片 最大宽高1280 类似于微信算法
- (UIImage *)getJPEGImagerImg:(UIImage *)image{
    CGFloat oldImg_WID = image.size.width;
    CGFloat oldImg_HEI = image.size.height;
    //CGFloat aspectRatio = oldImg_WID/oldImg_HEI;//宽高比
    if(oldImg_WID > KCompressibilityFactor || oldImg_HEI > KCompressibilityFactor){
        //超过设置的最大宽度 先判断那个边最长
        if(oldImg_WID > oldImg_HEI){
            //宽度大于高度
            oldImg_HEI = (KCompressibilityFactor * oldImg_HEI)/oldImg_WID;
            oldImg_WID = KCompressibilityFactor;
        }else{
            oldImg_WID = (KCompressibilityFactor * oldImg_WID)/oldImg_HEI;
            oldImg_HEI = KCompressibilityFactor;
        }
    }
    UIImage *newImg = [self imageWithImage:image scaledToSize:CGSizeMake(oldImg_WID, oldImg_HEI)];
    NSData *dJpeg = nil;
    if (UIImagePNGRepresentation(newImg)==nil) {
        dJpeg = UIImageJPEGRepresentation(newImg, 0.5);
    }else{
        dJpeg = UIImagePNGRepresentation(newImg);
    }
    return [UIImage imageWithData:dJpeg];
}

#pragma mark - 压缩多张图片 最大宽高1280 类似于微信算法
- (NSArray *)getJPEGImagerImgArr:(NSArray *)imageArr{
    NSMutableArray *newImgArr = [NSMutableArray new];
    for (int i = 0; i<imageArr.count; i++) {
        UIImage *newImg = [self getJPEGImagerImg:imageArr[i]];
        [newImgArr addObject:newImg];
    }
    return newImgArr;
}
#pragma mark - 压缩一张图片 自定义最大宽高
- (UIImage *)getJPEGImagerImg:(UIImage *)image compressibilityFactor:(CGFloat)compressibilityFactor{
    CGFloat oldImg_WID = image.size.width;
    CGFloat oldImg_HEI = image.size.height;
    //CGFloat aspectRatio = oldImg_WID/oldImg_HEI;//宽高比
    if(oldImg_WID > compressibilityFactor || oldImg_HEI > compressibilityFactor){
        //超过设置的最大宽度 先判断那个边最长
        if(oldImg_WID > oldImg_HEI){
            //宽度大于高度
            oldImg_HEI = (compressibilityFactor * oldImg_HEI)/oldImg_WID;
            oldImg_WID = compressibilityFactor;
        }else{
            oldImg_WID = (compressibilityFactor * oldImg_WID)/oldImg_HEI;
            oldImg_HEI = compressibilityFactor;
        }
    }
    UIImage *newImg = [self imageWithImage:image scaledToSize:CGSizeMake(oldImg_WID, oldImg_HEI)];
    NSData *dJpeg = nil;
    if (UIImagePNGRepresentation(newImg)==nil) {
        dJpeg = UIImageJPEGRepresentation(newImg, 0.5);
    }else{
        dJpeg = UIImagePNGRepresentation(newImg);
    }
    return [UIImage imageWithData:dJpeg];
}
#pragma mark - 压缩多张图片 自定义最大宽高
- (NSArray *)getJPEGImagerImgArr:(NSArray *)imageArr compressibilityFactor:(CGFloat)compressibilityFactor{
    NSMutableArray *newImgArr = [NSMutableArray new];
    for (int i = 0; i<imageArr.count; i++) {
        UIImage *newImg = [self getJPEGImagerImg:imageArr[i] compressibilityFactor:compressibilityFactor];
        [newImgArr addObject:newImg];
    }
    return newImgArr;
}
#pragma mark - 根据宽高压缩图片
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
