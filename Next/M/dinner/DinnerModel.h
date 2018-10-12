//
//  DinnerModel.h
//  Next
//
//  Created by csdc-iMac on 2018/9/25.
//  Copyright © 2018年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DinnerModel : NSObject
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userIconName;
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) NSArray *PhotoNameArray;
@property BOOL shouldForMore;
@property BOOL isOpen;
@end
