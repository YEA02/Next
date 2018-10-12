//
//  PhotoContainer.h
//  Next
//
//  Created by csdc-iMac on 2018/9/25.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"

@interface PhotoContainer : UIView <SDPhotoBrowserDelegate>
@property(nonatomic,strong) NSArray *statePhotoArray;
@property (nonatomic,strong) NSArray *imageViewsArray;
@end
