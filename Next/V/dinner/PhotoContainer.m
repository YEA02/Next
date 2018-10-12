//
//  PhotoContainer.m
//  Next
//
//  Created by csdc-iMac on 2018/9/25.
//  Copyright © 2018年 K. All rights reserved.
//

#import "PhotoContainer.h"
#import "UIView+SDAutoLayout.h"

@implementation PhotoContainer

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self create];
    }
    return self;
}

-(void)create{
    
    NSMutableArray *temp=[[NSMutableArray alloc]init];
    for(int i=0 ;i<9;i++){ //九张图
        UIImageView *imageView=[[UIImageView alloc]init];
        [self addSubview:imageView];
        imageView.userInteractionEnabled=YES;
        imageView.tag=i;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)]; //点击识别
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewsArray=[temp copy];
    
}


-(void)tapped:(UITapGestureRecognizer *)tap{
    UIView *imageView=tap.view;
    SDPhotoBrowser *browser=[[SDPhotoBrowser alloc]init];
    browser.currentImageIndex=imageView.tag;
    browser.sourceImagesContainerView=self;
    browser.imageCount=self.statePhotoArray.count;
    browser.delegate=self;
    [browser show];
}

-(void)setStatePhotoArray:(NSArray *)statePhotoArray{
    _statePhotoArray=statePhotoArray;  //给成员变量赋值
    
    for(long i=_statePhotoArray.count;i<self.imageViewsArray.count;i++)
    {
        UIImageView *imageView=[self.imageViewsArray objectAtIndex:i];
        imageView.hidden=YES;
    }  //少于九张，把少的几张图隐藏起来
    
    
    if(_statePhotoArray.count==0){
        self.height_sd=0;
        self.fixedHeight=@(0);
        return;
    }
    
    CGFloat itemW=[self itemWidthForStatePhotoArray:_statePhotoArray];
    CGFloat itemH=0;
    if(_statePhotoArray.count==1){
        UIImage *image=[UIImage imageNamed:_statePhotoArray.firstObject];
        if(image.size.width){
            itemH=image.size.height/image.size.width*itemW;
        }
    }else{
        itemH=itemW;
    }
    
    long perRowItemCount=[self perRowItemCountForStatePhotoArray:_statePhotoArray];
    CGFloat margin=5;
    [_statePhotoArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex=idx % perRowItemCount;
        long rowIndex=idx/perRowItemCount;
        UIImageView *imageView=[_imageViewsArray objectAtIndex:idx];
        imageView.hidden=NO;   //显示
        imageView.image=[UIImage imageNamed:obj];
        imageView.frame=CGRectMake(columnIndex * (itemW + margin), rowIndex*(itemH+margin), itemW, itemH);
    }];
    
    CGFloat w=perRowItemCount *itemW +(perRowItemCount-1)*margin;
    int columnCount=ceilf(_statePhotoArray.count*1.0/perRowItemCount);
    CGFloat h=columnCount *itemH +(columnCount -1)*margin;
    self.width_sd=w;
    self.height_sd=h;
    
    self.fixedHeight=@(h);
    self.fixedWidth=@(w);
    
}


-(CGFloat)itemWidthForStatePhotoArray:(NSArray *)array{
    if(array.count==1){
        return 120;
    }else{
        CGFloat w=[UIScreen mainScreen].bounds.size.width>320?80:70;
        return w;
    }
}


-(CGFloat)perRowItemCountForStatePhotoArray:(NSArray *)array{
    if(array.count<3){
        return array.count;
    }else if (array.count<=4)
    {
        return 2;
    }
    else{
        return 3;
    }
    
}

-(UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
    UIImageView *imageView=self.subviews[index];
    return imageView.image;
}



@end
