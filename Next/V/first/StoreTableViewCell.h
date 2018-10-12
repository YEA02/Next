//
//  StoreTableViewCell.h
//  Next
//
//  Created by csdc-iMac on 2018/7/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"


@interface StoreTableViewCell : UITableViewCell
@property UIImageView *view;
@property UILabel *storeNameLabel;
@property UILabel *storeDistanceLabel;
@property UILabel *storeDeliveryCostLabel;
-(void)setStoreModel:(StoreModel *)storeModel;
@end
