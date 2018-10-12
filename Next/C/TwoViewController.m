//
//  TwoViewController.m
//  Next

//  Created by csdc-iMac on 2018/9/19.
//  Copyright © 2018年 K. All rights reserved.
//

#import "TwoViewController.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"


#define mainscreenwidth self.view.bounds.size.width
#define mainscreenheight self.view.bounds.size.height
static CGFloat textFieldH=40;

@interface TwoViewController ()

@property (nonatomic,strong) UIButton *videoBtn;
@property (nonatomic,strong) UIButton *musicBtn;
@property (nonatomic,strong) UIButton *dinnerBtn;
@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *slideLab;
@property (nonatomic ,strong) UITableView *videoTV;
@property (nonatomic ,strong) UITableView *dinnerTV;
@property (nonatomic ,strong) UITableView *musicTV;
@property (nonatomic ,strong) UITableView *likeTV;
@property (nonatomic,strong) NSMutableArray *videoArray;
@property (nonatomic,strong) NSMutableArray *allCommentArray;
@property (nonatomic,strong) NSMutableArray *musicArray;
@property (nonatomic,strong) NSMutableArray *musicNameArray;
@property (nonatomic,strong) NSMutableArray *dinnerArray;

@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)NSIndexPath *currentIndexPath;
@property CGFloat keyboardHeight;
@property(nonatomic,copy)NSString *commentTo;
@property BOOL isReplyingComment;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.hidden=YES;
    self.edgesForExtendedLayout=UIRectEdgeNone;   //这个属性还不太懂的？？

    [self setupArray];
    [self setupTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];  //监听键盘尺寸通知，当收到UIKeyboardWillChangeFrameNotification通知时，调用keyboardNotification方法
    
    self.videoBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 30, mainscreenwidth/4, 20)];
    [self.videoBtn setTitle:@"视频" forState:UIControlStateNormal];
    [self.videoBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];  //默认被选中
    [self.videoBtn addTarget:self action:@selector(videoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.videoBtn];
    
    self.musicBtn=[[UIButton alloc]initWithFrame:CGRectMake(mainscreenwidth/4, 30, mainscreenwidth/4, 20)];
    [self.musicBtn setTitle:@"音乐" forState:UIControlStateNormal];
    [self.musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];  //默认没被选中
    [self.musicBtn addTarget:self action:@selector(musicBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.musicBtn];
    
    self.dinnerBtn=[[UIButton alloc]initWithFrame:CGRectMake(mainscreenwidth/4*2, 30, mainscreenwidth/4, 20)];
    [self.dinnerBtn setTitle:@"早午茶" forState:UIControlStateNormal];
    [self.dinnerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];  //默认没被选中
    [self.dinnerBtn addTarget:self action:@selector(dinnerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dinnerBtn];
    
    self.likeBtn=[[UIButton alloc]initWithFrame:CGRectMake(mainscreenwidth/4*3, 30, mainscreenwidth/4, 20)];
    [self.likeBtn setTitle:@"猜你喜欢" forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];  //默认没被选中
    [self.likeBtn addTarget:self action:@selector(likeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.likeBtn];
    
    self.slideLab=[[UILabel alloc]init];
    self.slideLab.frame=CGRectMake(20, 52, mainscreenwidth/4-40, 2);
    self.slideLab.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:self.slideLab];
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 55, mainscreenwidth, mainscreenheight)];
    self.scrollView.delegate=self;
    self.scrollView.contentSize=CGSizeMake(mainscreenwidth*4, mainscreenheight);
    self.scrollView.pagingEnabled=YES;   //一开始写成了scrollenabled ,然后出现一次会滑动很多页的情况，修改成pagingEnabled之后，变为一次滑动一页
    self.scrollView.bounces=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    [self.view addSubview:self.scrollView];

    self.videoTV=[[UITableView alloc]initWithFrame:CGRectMake(0, 2, mainscreenwidth, mainscreenheight-64-49) style:UITableViewStylePlain];
    self.videoTV.delegate=self;
    self.videoTV.dataSource=self;
    [self.scrollView addSubview:self.videoTV];
    
    self.musicTV=[[UITableView alloc]initWithFrame:CGRectMake(mainscreenwidth, 2, mainscreenwidth, mainscreenheight-64-49) style:UITableViewStylePlain];
    self.musicTV.delegate=self;
    self.musicTV.dataSource=self;
    [self.scrollView addSubview:self.musicTV];
       
    self.dinnerTV=[[UITableView alloc]initWithFrame:CGRectMake(mainscreenwidth*2, 2, mainscreenwidth, mainscreenheight-64-49) style:UITableViewStylePlain];
    self.dinnerTV.delegate=self;
    self.dinnerTV.dataSource=self;
    self.dinnerTV.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.dinnerTV];
    //解决点击按键时屏幕跳动的问题
    self.dinnerTV.estimatedRowHeight=0;
    self.dinnerTV.estimatedSectionFooterHeight=0;
    self.dinnerTV.estimatedSectionHeaderHeight=0;
    
    self.likeTV=[[UITableView alloc]initWithFrame:CGRectMake(mainscreenwidth*3, 2, mainscreenwidth, mainscreenheight-64-49) style:UITableViewStylePlain];
    self.likeTV.delegate=self;
    self.likeTV.dataSource=self;
    [self.scrollView addSubview:self.likeTV];
    
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(50, mainscreenheight-30-50, 100, 30)];
    self.pageControl.currentPage=0;
    self.pageControl.numberOfPages=4;
    self.pageControl.hidden=YES;
    [self.view addSubview:self.pageControl];
    
    
    // Do any additional setup after loading the view.
}

-(void)setupTextField{
    self.textField=[[UITextField alloc]init];
    self.textField.returnKeyType=UIReturnKeyDone;
    self.textField.delegate=self;
    self.textField.backgroundColor=[UIColor whiteColor];
    self.textField.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width_sd, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:self.textField];
    
    [self.textField becomeFirstResponder];
    [self.textField resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{

    [self.textField resignFirstResponder];
    
}

-(void)dealloc{
    [self.textField removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];  //移除键盘监听
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{ //开始滑动页面时，收回键盘
    [self.textField resignFirstResponder];
}

-(void)setupArray{
    VideoModel *videoM=[[VideoModel alloc]init];
    videoM.photoName=@"123.jpg";
    videoM.Name=@"Peter Elson";
    videoM.detail=@"Peter Elson (1947 – 1998)，英国科幻小说插画师，他的许多作品对后来的太空游戏创作产生了很大的影响,整整影响了一代科幻插图画家和概念艺术家。";
    CommentModel *commentModel1=[[CommentModel alloc]init];
    commentModel1.commentA=@"据了解";
    commentModel1.commentB=@"博客";
    commentModel1.commentDetail=@"胜利路南";
    videoM.commentModelArray=[[NSArray alloc]initWithObjects:commentModel1, nil];
    
    VideoModel *videoM2=[[VideoModel alloc]init];
    videoM2.photoName=@"124.jpg";
    videoM2.Name=@"美丽的黄昏";
    videoM2.detail=@"三个月前，不顾朋友、家人、同事反对，毅然决然地做了一件想了三年的事——记录这个时代的建筑者。";
    CommentModel *commentModel2=[[CommentModel alloc]init];
    commentModel2.commentA=@"姜汁";
    commentModel2.commentB=@"普洱";
    commentModel2.commentDetail=@"是你每次";
    videoM2.commentModelArray=[[NSArray alloc]initWithObjects:commentModel2,commentModel1, nil];
    
    VideoModel *videoM3=[[VideoModel alloc]init];
    videoM3.photoName=@"125.jpg";
    videoM3.Name=@"MusicWars";
    videoM3.detail=@"电影版《唐顿庄园》北美正式定档2019年9月20日！其他部分地区将于9月13日上线！电视剧版的演员Maggie Smith、Hugh Bonneville、Michelle Dockery、Elizabeth McGovern等人将确定回归影版";
    CommentModel *commentModel3=[[CommentModel alloc]init];
    commentModel3.commentA=@"欧派";
    commentModel3.commentB=@"思想";
    commentModel3.commentDetail=@"主持稿";
    videoM3.commentModelArray=[[NSArray alloc]initWithObjects:commentModel1,commentModel3,commentModel2,nil];
    
    VideoModel *videoM4=[[VideoModel alloc]init];
    videoM4.photoName=@"126.jpg";
    videoM4.Name=@"艾薇儿Avril";
    videoM4.detail=@"艾薇儿Avril回归新单《Head Above Water》歌词版超清MV大首播！这首歌曲是艾薇儿Avril患病期间卧床写的，艾薇儿说：我已经接受了死亡，可以感受到我的身体正在关闭，就像溺水，我正在水里面，很需要赶快上去吸一口气。整首歌都是记录她患病那些日子的感受！";
    CommentModel *commentModel4=[[CommentModel alloc]init];
    commentModel4.commentA=@"皮特";
    commentModel4.commentB=@"如律";
    commentModel4.commentDetail=@"大考卷下半年";
    videoM4.commentModelArray=[[NSArray alloc]initWithObjects:commentModel1,commentModel3,commentModel4,nil];
    
    VideoModel *videoM5=[[VideoModel alloc]init];
    videoM5.photoName=@"127.jpg";
    videoM5.Name=@"伪命题";
    videoM5.detail=@"随着沪深股市持续下跌，外资抄底A股的声音又出现了。其实，此前股市下跌后如果出现大幅上涨行情，总有某某资金抄底的声音，比如险资、比如外资。";
    CommentModel *commentModel5=[[CommentModel alloc]init];
    commentModel5.commentA=@"麦炒饼VS炒面";
    commentModel5.commentB=@"坐标系";
    commentModel5.commentDetail=@"突然好怀念吧";
    videoM5.commentModelArray=[[NSArray alloc]initWithObjects:commentModel1,commentModel4,commentModel2,nil];

    self.videoArray=[[NSMutableArray alloc]initWithObjects:videoM,videoM2,videoM3,videoM4,videoM5, nil];
    
    MusicModel *musicM=[[MusicModel alloc]init];
    musicM.PicName=@"01.jpg";
    musicM.userName=@"YUE XUAN";
    musicM.titleName=@"好好";
    musicM.userPhotoName=@"125.jpg";
    musicM.musicName=@"好好";
    musicM.detailName=@"《好好（想把你写成一首歌）》是由阿信作词，冠佑、阿信作曲、五月天演唱的歌曲，收录在五月天第9张专辑《自传》中。于2016年10月11日作为新海诚动漫电影《你的名字》的台湾地区宣传曲。";
    
    MusicModel *musicM2=[[MusicModel alloc]init];
    musicM2.PicName=@"0.jpeg";
    musicM2.userName=@"AwLi";
    musicM2.titleName=@"Peter Elson ";
    musicM2.userPhotoName=@"126.jpg";
    musicM2.musicName=@"像我这样的人";
    musicM2.detailName=@"小时候的毛不易觉得自己是个非常与众不同的人，但随着年龄的增长，毛不易发现自己可能并没有那么特别，对于那种泯然众人的感觉让他觉得很难受，他觉得很不甘心 ，却又无能为力。在毛不易面临大学毕业的时，他试图逃离现状，又不知去往何处。2016年，毛不易在杭州地方医院实习时，他开始提笔写歌，他把这样的自己写进了歌曲《像我这样的人》中。";
    
    MusicModel *musicM3=[[MusicModel alloc]init];
    musicM3.PicName=@"02";
    musicM3.userName=@"MOWEN";
    musicM3.titleName=@"好久不见";
    musicM3.userPhotoName=@"127.jpg";
    musicM3.musicName=@"好久不见";
    musicM3.detailName=@"《好久不见》是翻唱陈奕迅的粤语专辑《What's Going On...?》中的歌曲《不如不见》，《不如不见》由创作了《十年》的陈小霞作曲，请到作词人施立填上国语歌词，来描述期望和旧情人重逢，可以淡淡说声好久不见的意境，词填得不温不火，似只是在喃喃述说一个再也平常不过的爱情故事，适合陈奕迅淡定落寞却又充满沧桑沙哑的声音，谱写出一首凄美的情歌";
    
    MusicModel *musicM4=[[MusicModel alloc]init];
    musicM4.PicName=@"03.jpeg";
    musicM4.userName=@"yanY";
    musicM4.titleName=@"等你下课 ";
    musicM4.userPhotoName=@"128.jpg";
    musicM4.musicName=@"等你下课";
    musicM4.detailName=@"2017年忙碌于巡回演唱会的周杰伦，心里一直惦记着不想让歌迷等新歌等太久。周杰伦趁着演唱会的庆功宴空档写歌，当工作人员在庆功宴上放松时，他灵感来了就回到自己的房间里，拿起吉他轻刷旋律写下这首《等你下课》，词曲皆出自周杰伦之手，一气呵成。";
    
    MusicModel *musicM5=[[MusicModel alloc]init];
    musicM5.PicName=@"04.jpg";
    musicM5.userName=@"往事随风";
    musicM5.titleName=@"告白气球";
    musicM5.userPhotoName=@"124.jpg";
    musicM5.musicName=@"告白气球";
    musicM5.detailName=@"词作者方文山为周杰伦创作了《印地安老斑鸠》之后，在《周杰伦的睡前故事》这张专辑里为周杰伦量身打造了一首甜美浪漫曲风的歌曲——《告白气球》。该歌曲灵感来源于法国的美景，觉得应该来一首《简单爱》类似的歌曲创作，回顾一下以前那种对于初恋、小清新的感觉。在创作过程中周杰伦一直保持着童心未泯的心态与方文山一起合作，自己坦言这首歌是专辑里面，写得最简单的，最好写的。";
    
    self.musicArray=[[NSMutableArray alloc]initWithObjects:musicM,musicM2,musicM3,musicM4,musicM5, nil];
    self.musicNameArray=[[NSMutableArray alloc]initWithObjects:@"好好",@"像我这样的人",@"好久不见",@"等你下课",@"告白气球", nil];
    
    DinnerModel *dinnerM=[[DinnerModel alloc]init];
    dinnerM.userIconName=@"棒棒糖";
    dinnerM.userName=@"棒棒糖";
    dinnerM.detail=@"1758年，闻名世界的棒棒糖（lollipop）的发明人恩里克·伯纳特·丰利亚多萨，首次推出这种带棍的糖果，结果使一家几乎经营不下去的糖果公司扭亏为盈。";
    dinnerM.PhotoNameArray=@[@"12344.jpg",@"123445.jpg"];
    
    DinnerModel *dinnerM2=[[DinnerModel alloc]init];
    dinnerM2.userIconName=@"冰淇凌";
    dinnerM2.userName=@"冰淇淋";
    dinnerM2.detail=@"将近800年以前，冰淇淋源于中国。在元朝的时候，一位精明的食品店商人突发奇想，他尝试着在冰中添加一些蜜糖、牛奶和珍珠粉，结果，制成了世界上最早的冰淇淋。";
    dinnerM2.PhotoNameArray=@[];
//    dinnerM2.PhotoNameArray=[[NSArray alloc]initWithObjects:@"12355.jpg",@"123556.jpg",@"123557.jpg",@"123558.jpg",nil];
    
    DinnerModel *dinnerM3=[[DinnerModel alloc]init];
    dinnerM3.userIconName=@"沙拉";
    dinnerM3.userName=@"沙拉";
    dinnerM3.detail=@"主要有三类，水果沙拉、蔬菜沙拉、其他沙拉。由绿色有叶生菜制成的一道菜，常加有萝卜、黄瓜或西红柿，并加调味品食用。";
    dinnerM3.PhotoNameArray=@[@"123559.jpg",@"1235510.jpg"];
    
    DinnerModel *dinnerM4=[[DinnerModel alloc]init];
    dinnerM4.userIconName=@"薯条可乐";
    dinnerM4.userName=@"薯条可乐";
    dinnerM4.detail=@"薯条的英文是“Chips”，美国人称之为“French Fries”.";
 dinnerM4.PhotoNameArray=@[@"1235511.jpg",@"1235512.jpg",@"1235513",@"1235514.jpg"];
    
    DinnerModel *dinnerM5=[[DinnerModel alloc]init];
    dinnerM5.userIconName=@"甜甜圈";
    dinnerM5.userName=@"甜甜圈";
    dinnerM5.detail=@"现在的甜甜圈在美国还是最为受欢迎的一种甜品，任何一个糕点店铺或快餐店都有出售。从5岁儿童到75岁老人都对它有着一致的热爱。";
    dinnerM5.PhotoNameArray=@[@"1235515.jpg"];
    
    self.dinnerArray=[[NSMutableArray alloc]initWithObjects:dinnerM,dinnerM2,dinnerM3,dinnerM4,dinnerM5, nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGFloat offset=self.scrollView.contentOffset.x;
    int page=(offset+mainscreenwidth/2)/mainscreenwidth;
    self.pageControl.currentPage=page;

    if(self.pageControl.currentPage==0){
        [self videoBtnClick];
    }else if (self.pageControl.currentPage==1){
        [self musicBtnClick];
    }else if (self.pageControl.currentPage==2){
        [self dinnerBtnClick];
    }else{
        [self likeBtnClick];
    }
}

-(void)videoBtnClick{
    self.slideLab.frame=CGRectMake(20, 52, mainscreenwidth/4-40, 2);  //横条滑动
    [self.videoBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.dinnerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self.scrollView setContentOffset:CGPointMake(mainscreenwidth*0, 0)];
    [UIView commitAnimations];
}

-(void)musicBtnClick{
    self.slideLab.frame=CGRectMake(20+mainscreenwidth/4, 52, mainscreenwidth/4-40, 2);//横条滑动
    [self.videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.musicBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.dinnerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self.scrollView setContentOffset:CGPointMake(mainscreenwidth*1, 0)];
    [UIView commitAnimations];
}


-(void)dinnerBtnClick{
    self.slideLab.frame=CGRectMake(20+2*mainscreenwidth/4, 52, mainscreenwidth/4-40, 2);//横条滑动
    [self.videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.dinnerBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self.scrollView setContentOffset:CGPointMake(mainscreenwidth*2, 0)];
    [UIView commitAnimations];
}


-(void)likeBtnClick{
    self.slideLab.frame=CGRectMake(20+3*mainscreenwidth/4, 52, mainscreenwidth/4-40, 2);//横条滑动
    [self.videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.musicBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.dinnerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];

    [self.scrollView setContentOffset:CGPointMake(mainscreenwidth*3, 0)];
    [UIView commitAnimations];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==self.videoTV)
        return _videoArray.count;
    else if(tableView==self.musicTV)
        return  _musicArray.count;
    else if(tableView==self.dinnerTV)
        return _dinnerArray.count;
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *iden=@"iden";
    
    if(tableView==self.videoTV){
        VideoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
        if(cell==nil){
            cell=[[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        cell.delegate=self;
        [cell setModel:_videoArray[indexPath.row]];
        return cell;
    }
    else if(tableView==self.musicTV){
        MusicTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
        if(cell==nil){
            cell=[[MusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
//        cell.delegate=self;
        [cell setModel:_musicArray[indexPath.row]];
        return cell;
    }
    else if(tableView==self.dinnerTV){
        DinnerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
        if(cell==nil){
            cell=[[DinnerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        cell.delegate=self;
        [cell setModel:_dinnerArray[indexPath.row]];
        return cell;
        }
    else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:iden];
        if(cell==nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        cell.textLabel.text=@"14";
        return cell;
    }
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(tableView==self.musicTV){
//        MusicTableViewCell *cell=[self.musicTV cellForRowAtIndexPath:indexPath];
//        cell.isPlay=!cell.isPlay;
//
//        [cell setPlay: self.musicNameArray[indexPath.row]];
//    }
//
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.text.length){
        [textField resignFirstResponder];
        VideoModel *model=self.videoArray[self.currentIndexPath.row];  //取出当前model
        NSMutableArray *temp=[[NSMutableArray alloc]init];
        [temp addObjectsFromArray:model.commentModelArray];  //添加当前model的所有评论数组
        CommentModel *commentModel=[[CommentModel alloc]init];
        commentModel.commentA=@"K";
        if(self.isReplyingComment){   //回复他人评论
            commentModel.commentDetail=textField.text;
            commentModel.commentB=self.commentTo;
            self.isReplyingComment=NO;
        }else{
            commentModel.commentDetail=textField.text;
        }
        [temp addObject:commentModel];   //添加新的评论数组
        model.commentModelArray=[temp copy];   //更新得到新的commentModelArray
        
        [self.videoTV reloadRowsAtIndexPaths:@[self.currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];   //刷新当前行
        self.textField.text=@"";
        return YES;
    }
    return NO;
}


-(void)didClickForMore:(DinnerTableViewCell *)cell{
    NSIndexPath *indexPath=[self.dinnerTV indexPathForCell:cell];
    DinnerModel *model=_dinnerArray[indexPath.row];
    model.isOpen=!model.isOpen;
//    [self.dinnerTV  reloadData];
    [self.dinnerTV reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];    //更新当前行
}

-(void)didClickComment:(VideoTableViewCell *)cell{   //实现协议定义的方法
    //协议传递cell值，获取cell然后执行下面的操作
    
    [self.textField becomeFirstResponder];
    self.currentIndexPath=[self.videoTV indexPathForCell:cell];   //获取当前行
    [self adjust];
}

-(void)didComment:(VideoTableViewCell *)cell andString:(NSString*)string{
    [self.textField becomeFirstResponder];
    self.currentIndexPath=[self.videoTV indexPathForCell:cell];   //获取当前行
    self.commentTo=string;
    [self adjust];
    self.isReplyingComment=cell.isReplying;
}


-(void)keyboardNotification:(NSNotification *)notification{  //键盘高度适应
    NSDictionary *dic=notification.userInfo;  //获取userInfo字典数据
    CGRect rect=[dic[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    
    CGRect textFieldRect =CGRectMake(0, rect.origin.y-textFieldH, rect.size.width, textFieldH);
    if(rect.origin.y==[UIScreen mainScreen].bounds.size.height){
        textFieldRect=rect;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.textField.frame=textFieldRect;
        
    }];
    CGFloat h=rect.size.height+textFieldH;
    if(self.keyboardHeight!=h){
        self.keyboardHeight=h;
        [self adjust];
    }
}

-(void)adjust{
    UIWindow *win=[UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell=[self.videoTV cellForRowAtIndexPath:self.currentIndexPath];
    CGRect rect=[cell.superview convertRect:cell.frame toView:win];
    CGFloat de=CGRectGetMaxY(rect)-(win.bounds.size.height-self.keyboardHeight);
    CGPoint offset=self.videoTV.contentOffset;
    offset.y+=de;
    if(offset.y<0){
        offset.y=0;}
    [self.videoTV setContentOffset:offset animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell高度自适应
    if(tableView==_videoTV){
    return [self.videoTV cellHeightForIndexPath:indexPath model:self.videoArray[indexPath.row] keyPath:@"model" cellClass:[VideoTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    }else if(tableView==_musicTV){
        return [self.musicTV cellHeightForIndexPath:indexPath model:self.musicArray[indexPath.row] keyPath:@"model" cellClass:[MusicTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    }else if(tableView==_dinnerTV){
        return [self.dinnerTV cellHeightForIndexPath:indexPath model:self.dinnerArray[indexPath.row] keyPath:@"model" cellClass:[DinnerTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    }else{
        return 40;
    }
}

- (CGFloat)cellContentViewWith{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

//-(void) didClickPlay:(MusicTableViewCell *) cell{   //实现协议定义的方法
//    NSIndexPath *index=[self.musicTV indexPathForCell:cell];
//    MusicModel *model=self.musicArray[index.row];
//    model.Play=!model.Play;
//    [self.musicTV reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];   //记得更新tableview，否则看不出变化
//}

-(void) didShare:(UIActivityViewController *)activityVC{   //实现协议定义的方法    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
