//
//  CommentView.h
//  Next
//
//  Created by csdc-iMac on 2018/9/23.
//  Copyright © 2018年 K. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@protocol commentProtocol<NSObject>
-(void)commentClick:(NSString *)string;
@end

@interface CommentView : UIView

@property(nonatomic,strong)UIImageView *backGroundIV;
@property (nonatomic,strong) NSArray *commentArray; //存放评论model
@property (nonatomic,strong) NSMutableArray *commentItemsArray;
@property (nonatomic,weak) id <commentProtocol> delegate;

-(void)setCommentView:(NSArray *)commentModelArray;

@end
