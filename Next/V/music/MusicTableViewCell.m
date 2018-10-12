//
//  MusicTableViewCell.m
//  Next
//  多首音乐会同时播放的问题还没解决 ，播放歌曲模糊背景也没实现，而且，一首歌结束后，按键不会切换为开始的样式，还有滑动页面的时候，歌曲会停止。？？？
//  Created by csdc-iMac on 2018/9/20.
//  Copyright © 2018年 K. All rights reserved.
//

#import "MusicTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import <AVFoundation/AVFoundation.h>
//#import "UIImage+ImageEffects.h"
@interface MusicTableViewCell () <AVAudioPlayerDelegate>


@property (nonatomic,strong) AVAudioPlayer *player;  //播放器
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIProgressView *progress; //播放进度条
@property (nonatomic,strong) UISlider *slider;   //用滑动器来控制音量大小
@property (nonatomic,strong) NSTimer *timer;   //更新歌曲当前时间
@property (nonatomic,strong) UILabel *timeLabel;  //显示时间
@end

@implementation MusicTableViewCell 

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.player.delegate=self;
        [self creatUI];
    }
    return self;
}


-(void)creatUI{
    
    self.picView=[[UIImageView alloc]init];
    [self.contentView addSubview:self.picView];
    
    self.userNameLabel=[[UILabel alloc]init];
    self.userNameLabel.textAlignment=NSTextAlignmentLeft;
    self.userNameLabel.font=[UIFont systemFontOfSize:19];
    [self.contentView addSubview:self.userNameLabel];
    
    self.userPhtoView=[[UIImageView alloc]init];
    [self.contentView insertSubview:self.userPhtoView atIndex:0];
    
    
    self.button=[UIButton buttonWithType:UIButtonTypeCustom];  //改为UIButtonTypeCustom ，按键不会默认蓝色
    [self.button setImage:[UIImage imageNamed:@"开始-6"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
    
    self.progress=[[UIProgressView alloc]init];     //实例化进度条
    self.progress.progress=0;
    [self.contentView addSubview:self.progress];
    
    self.timeLabel=[[UILabel alloc]init];
    self.timeLabel.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.timeLabel];
    
    
    self.slider=[[UISlider alloc]init];
    self.slider.minimumValue=0;
    self.slider.maximumValue=10;
    [self.slider setThumbImage:[UIImage imageNamed: @"圆盘-2"] forState:UIControlStateNormal];
    self.slider.transform=CGAffineTransformMakeRotation(-M_PI_2);
    [self.slider addTarget:self action:@selector(changeVo) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.slider];
    
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.font=[UIFont systemFontOfSize:23];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel=[[UILabel alloc]init];
    self.detailLabel.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.detailLabel];
    
    self.picView.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightIs(40);
    
    self.userNameLabel.sd_layout
    .leftSpaceToView(self.picView, 10)
    .centerYEqualToView(self.picView)
    .widthIs(150)
    .heightIs(30);
    
    self.userPhtoView.sd_layout
    .leftEqualToView(self.picView)
    .topSpaceToView(self.picView, 15)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(160);
    
    self.button.sd_layout
    .centerYEqualToView(self.userPhtoView)
    .centerXEqualToView(self.userPhtoView)
    .widthIs(80)
    .heightIs(80);
    
    
    self.progress.sd_layout
    .topSpaceToView(self.button, 20)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 50)
    .heightIs(15);
    
    self.timeLabel.sd_layout
    .widthIs(200)
    .leftEqualToView(self.progress)
    .topSpaceToView(self.button, 3)
    .heightIs(15);
    
    
    self.slider.sd_layout
    .bottomEqualToView(self.progress)
    .widthIs(10)
    .rightSpaceToView(self.contentView, 18)
    .heightIs(100);
    
    self.titleLabel.sd_layout
    .leftEqualToView(self.userPhtoView)
    .rightEqualToView(self.userPhtoView)
    .topSpaceToView(self.userPhtoView, 15)
    .autoHeightRatio(0);
    
    self.detailLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel)
    .topSpaceToView(self.titleLabel, 15)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.detailLabel bottomMargin:20];
    

}

-(void)time{
    NSTimeInterval totalTime=self.player.duration;
    NSTimeInterval currentTime=self.player.currentTime;
    self.progress.progress=(currentTime/totalTime);
    
    
    NSTimeInterval currentM=currentTime/60;
    currentTime=(int)currentTime%60;
    
    NSTimeInterval totalM=totalTime/60;
    totalTime=(int)totalTime%60;
    
    NSString *timeString=[NSString stringWithFormat:@"%02.0f:%02.0f|%02.0f:%02.0f",currentM,currentTime,totalM,totalTime];
    self.timeLabel.text=timeString;

}


-(void)changeVo{
    self.player.volume=self.slider.value;
}

-(void)play:(UIButton *)sender{
    self.isPlay=!self.isPlay;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSURL *musicUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.playNow ofType:@"mp3"]];
//        self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:musicUrl error:nil];
//    });

    if(self.isPlay==NO){
        [self.button setImage:[UIImage imageNamed:@"开始-6"] forState:UIControlStateNormal];
        [self.player pause];

        self.userPhtoView.alpha=1;

    }else{
        [self.button setImage:[UIImage imageNamed:@"暂停-6"] forState:UIControlStateNormal];
        [self.player play];
        self.userPhtoView.alpha=0.6;  //本来是使背景图变模糊，结果没成功，现在是修改透明度
    }

//    [self.delegate didClickPlay:self];   //协议方法，传递值是当前cell，即self
}
//-(void)setPlay:(NSString*) playNow{
//    static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            NSURL *musicUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:playNow ofType:@"mp3"]];
//            self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:musicUrl error:nil];
//        });
//
//        if(self.isPlay==NO){
//            [self.button setImage:[UIImage imageNamed:@"开始-6"] forState:UIControlStateNormal];
//            [self.player pause];
//
//            self.userPhtoView.alpha=1;
//
//        }else{
//            [self.button setImage:[UIImage imageNamed:@"暂停-6"] forState:UIControlStateNormal];
//            [self.player play];
//            self.userPhtoView.alpha=0.6;  //本来是使背景图变模糊，结果没成功，现在是修改透明度
//        }
//
//}

-(void)setModel:(MusicModel *) musicModel{
    NSURL *musicUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:musicModel.musicName ofType:@"mp3"]];
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:musicUrl error:nil];

//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSURL *musicUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.playNow ofType:@"mp3"]];
//        self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:musicUrl error:nil];
//    });
//
//    if(self.isPlay==NO){
//        [self.button setImage:[UIImage imageNamed:@"开始-6"] forState:UIControlStateNormal];
//        [self.player pause];
//
//        self.userPhtoView.alpha=1;
//
//    }else{
//        [self.button setImage:[UIImage imageNamed:@"暂停-6"] forState:UIControlStateNormal];
//        [self.player play];
//        self.userPhtoView.alpha=0.6;  //本来是使背景图变模糊，结果没成功，现在是修改透明度
//    }
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time) userInfo:nil repeats:YES];
    
    self.titleLabel.text=musicModel.titleName;
    self.detailLabel.text=musicModel.detailName;
    self.picView.image=[UIImage imageNamed:musicModel.PicName];
    self.userNameLabel.text=musicModel.userName;
    self.userPhtoView.image=[UIImage imageNamed:musicModel.userPhotoName];
//    if(self.isPlay==YES){
//        UIImage *sourceImg=[UIImage imageNamed:musicModel.userPhotoName];
//        UIImage *blurImage = [sourceImg blurImageWithRadius:20];
//        self.userPhtoView.image=blurImage;
//    }

//        CIContext *context=[CIContext contextWithOptions:nil];
//        CIImage *ciImage = [[CIImage alloc]initWithImage:[UIImage imageNamed:musicModel.userPhotoName]];
//        CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
//        [blurFilter setValue:ciImage forKey:kCIInputImageKey];
//        [blurFilter setValue:@(20) forKey:@"inputRadius"];
//        CIImage *outciImage=[blurFilter valueForKey:kCIOutputImageKey];
//        CGImageRef outCGImage = [context createCGImage:outciImage fromRect:outciImage.extent];
//        UIImage *blurImage =[UIImage imageWithCGImage:outCGImage];
//        CGImageRelease(outCGImage);
//        self.userPhtoView.image=blurImage;  //卡顿
}

//-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{  //播放完成，没有用
//    [self.button setImage:[UIImage imageNamed:@"开始-6"] forState:UIControlStateNormal];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
