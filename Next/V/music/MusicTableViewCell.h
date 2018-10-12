//
//  MusicTableViewCell.h
//  Next
//
//  Created by csdc-iMac on 2018/9/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
@class MusicTableViewCell;

//@protocol MusicTableViewCellDelegate <NSObject>   //声明协议
//-(void) didClickPlay:(MusicTableViewCell *) cell;
//@end

@interface MusicTableViewCell : UITableViewCell 
//@property (nonatomic,weak)id<MusicTableViewCellDelegate>delegate;
@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UIImageView *userPhtoView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property BOOL isPlay;
@property (nonatomic,strong) NSString *playNow;

-(void)setModel:(MusicModel *) musicModel;

//-(void)setPlay:(NSString*) playNow;
@end
