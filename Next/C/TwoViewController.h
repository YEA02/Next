//
//  TwoViewController.h
//  Next
//
//  Created by csdc-iMac on 2018/9/19.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicTableViewCell.h"
#import "OperationMenu.h"
#import "VideoTableViewCell.h"
#import "VideoModel.h"
#import "CommentModel.h"
#import "DinnerTableViewCell.h"

@interface TwoViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,ShareClick,forMoreProtocol>

@end
