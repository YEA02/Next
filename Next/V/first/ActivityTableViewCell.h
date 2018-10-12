//
//  ActivityTableViewCell.h
//  Next
//
//  Created by csdc-iMac on 2018/7/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityModel.h"
@interface ActivityTableViewCell : UITableViewCell
@property UIImageView *activityImage1;
@property UILabel *activityNameLabel1;
@property UILabel *activityDetailLabel1;
@property UIImageView *activityImage2;
@property UILabel *activityNameLabel2;
@property UILabel *activityDetailLabel2;

-(void)setActivityModel:(ActivityModel *)activityModel;
@end
