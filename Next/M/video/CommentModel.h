//
//  CommentModel.h
//  Next
//
//  Created by csdc-iMac on 2018/9/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic,strong) NSString *commentA;  //评论者
@property (nonatomic,strong) NSString *commentB;  //被评论者
@property (nonatomic,strong) NSString *commentDetail;  //评论内容
@property (nonatomic,strong) NSAttributedString *attributedContent;  //整合后的评论内容
@end
