//
//  ViewController.h
//  Next
//
//  Created by csdc-iMac on 2018/7/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
-(void)setStoreArray;
-(void)setFoodArray;
-(void)setActivityModel;
@end

