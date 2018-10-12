//
//  VideoModel.h
//  Next
//
//  Created by csdc-iMac on 2018/9/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property (nonatomic,strong) NSString *photoName;
@property (nonatomic,strong) NSString *Name;
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) NSArray *commentModelArray; //评论数组

@end 
