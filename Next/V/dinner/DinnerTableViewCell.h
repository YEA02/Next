//
//  DinnerTableViewCell.h
//  Next
//
//  Created by csdc-iMac on 2018/9/25.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DinnerModel.h"
#import "PhotoContainer.h"

@class DinnerTableViewCell;

@protocol forMoreProtocol <NSObject>
-(void)didClickForMore:(DinnerTableViewCell *)cell;
@end

@interface DinnerTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *userImg;
@property (nonatomic,strong) UILabel *userLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *formore;
@property BOOL isOpen;
@property (nonatomic,strong) PhotoContainer *phtoContainer;
@property (nonatomic,weak)id <forMoreProtocol>delegate;
-(void)setModel:(DinnerModel *)dinnerModel ;
@end
