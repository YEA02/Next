//
//  FoodCollectionViewCell.h
//  Next
//
//  Created by csdc-iMac on 2018/9/18.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodModel.h"
@interface FoodCollectionViewCell : UICollectionViewCell
@property UIImageView *foodPhoto;
@property UILabel *foodNameLabel;
-(void)setModel:(FoodModel *)foodModel;
@end
