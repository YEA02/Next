//
//  DinnerModel.m
//  Next
//
//  Created by csdc-iMac on 2018/9/25.
//  Copyright © 2018年 K. All rights reserved.
//

#import "DinnerModel.h"
#import <UIKit/UIKit.h>

extern CGFloat maxHeight;
@implementation DinnerModel{
    CGFloat _lastContentWidth;
}
@synthesize detail=_detail;

-(void)setDetail:(NSString *)detail{  //set方法
    _detail=detail;
}

-(NSString *)detail{   //get方法
    CGFloat contentw=[UIScreen mainScreen].bounds.size.width-70;
    if(contentw !=_lastContentWidth){
        _lastContentWidth=contentw;
        CGRect textRect=[_detail boundingRectWithSize:CGSizeMake(contentw, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
        
        if(textRect.size.height>maxHeight) {
            _shouldForMore=YES;   //超过三行，需要“查看更多”
        }
        else{
            _shouldForMore=NO;   //不需要“查看更多”
        }
    }
    return _detail;
}

@end
