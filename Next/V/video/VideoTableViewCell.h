//
//  VideoTableViewCell.h
//  Next
//
//  Created by csdc-iMac on 2018/9/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "CommentModel.h"
#import "OperationMenu.h"
#import "CommentView.h"

@class VideoTableViewCell;

@protocol ShareClick <NSObject>   //声明协议
-(void) didShare:(UIActivityViewController *)activityVC;
-(void) didClickComment:(VideoTableViewCell *)cell;
-(void) didComment:(VideoTableViewCell *)cell andString:(NSString*)string;
@end


@interface VideoTableViewCell : UITableViewCell <OperationMenuClick,commentProtocol>
@property (nonatomic,strong) UIImageView *photoImg;
@property (nonatomic,strong ) UILabel *nameLabel;
@property (nonatomic,strong ) UILabel *detailLabel;
@property (nonatomic,strong ) OperationMenu *operationMenu;
@property (nonatomic,strong ) CommentView *commentView;;
@property (nonatomic,weak) id <ShareClick> delegate;
@property BOOL isReplying;
-(void)setModel:(VideoModel *) videoModel;
@end
