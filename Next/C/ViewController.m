//
//  ViewController.m
//  Next
//
//  Created by csdc-iMac on 2018/7/20.
//  Copyright © 2018年 K. All rights reserved.
//
#define MAINSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define MAINSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "StoreTableViewCell.h"
#import "ActivityTableViewCell.h"
#import "FoodCollectionViewCell.h"
#import "FoodModel.h"

@interface ViewController ()
@property NSMutableArray *storeArray;
@property NSMutableArray *foodArray;
@property ActivityModel *activityModel;
@property UIPageControl *pageControl;
@property UICollectionView *collectionView;
@property UIScrollView *backScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;

    
    self.backScrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.backScrollView.delegate=self;
    self.backScrollView.contentSize=CGSizeMake(MAINSCREENWIDTH, 1330);
    self.backScrollView.scrollEnabled=YES;
    [self.view addSubview:self.backScrollView];   //把高度写固定，将scrollview、tableView、collectionview 一起放到这个总的背景backscrollview中，设定tableView、collectionview禁止滚动，允许backscrollview可以滚动，就可以实现tableView、collectionview的联动滚动
    
    //轮播图
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREENWIDTH, 220)]; //设置frame
    [scrollView setTag:12];  //轮播图
    scrollView.delegate=self; //设置代理，把权限给了这个视图
    scrollView.contentSize=CGSizeMake(MAINSCREENWIDTH*6, 220);  //设置滑动范围,6张图
    scrollView.pagingEnabled=YES;  //设置分页效果
    scrollView.showsHorizontalScrollIndicator=NO; //关闭水平指示器
    scrollView.showsVerticalScrollIndicator=NO;  //关闭垂直指示器
    NSMutableArray *scrollPicture=[[NSMutableArray alloc]initWithObjects:@"ad1.jpg",@"ad2.jpg",@"ad3.jpg",@"ad4.jpg",@"ad5.jpg",@"ad6.jpg", nil];
    for(int i=0;i<6;i++)
    {
        CGFloat x=i*MAINSCREENWIDTH;
        UIImageView *scrollImage=[[UIImageView alloc]init];
        scrollImage.frame=CGRectMake(x, 0, MAINSCREENWIDTH, 220);
        scrollImage.image=[UIImage imageNamed:scrollPicture[i]];
        [scrollView addSubview:scrollImage];
    }
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((MAINSCREENWIDTH-100)/2, 200, 100, 20)];
    self.pageControl.currentPage=0;  //当前页面是0
    self.pageControl.numberOfPages=6; //总共6个图片
    self.pageControl.currentPageIndicatorTintColor=[UIColor whiteColor]; //设置当前选中的点的颜色
    self.pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];  //设置未选中的点的颜色
    [self.backScrollView addSubview:scrollView];
//    [self.view addSubview:scrollView];
//    table.tableHeaderView=scrollView; //将轮播图作为表头
//    [table addSubview:scrollView];
//    [self.view addSubview:self.pageControl];
    [self.backScrollView addSubview:self.pageControl];

    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 230, MAINSCREENWIDTH, 220) collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator=NO;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:self.collectionView];
    [self.backScrollView addSubview:self.collectionView];
    
    [self.collectionView registerClass:[FoodCollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];   //注册cell
    layout.minimumLineSpacing=0;
    layout.sectionInset=UIEdgeInsetsMake(0, 9, 0, 9);
    layout.itemSize=CGSizeMake(MAINSCREENWIDTH/4-25, 110);  //每个cell的大小
    
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(0, 30+scrollView.frame.size.height+self.collectionView.frame.size.height, MAINSCREENWIDTH, 800) style:UITableViewStyleGrouped];
    table.delegate=self;
    table.dataSource=self;  //设置数据源
    table.scrollEnabled=NO;
//    [self.view addSubview:table];
    [self.backScrollView addSubview:table];
    
    [self setFoodArray];
    [self setStoreArray];
    [self setActivityModel];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{//当滑动快要结束时，调用这个方法,控制下面那个滚动栏的滑动
    if(scrollView.tag==12){   //发现整个backscrollview是垂直滑动，而scrollview是水平滑动，会互相干扰，所以用tag来标识两个scrollview  。 网上还有看到判断移动距离来判断是水平滑动还是垂直滑动的，感觉略复杂，就跳过了
    CGFloat offset=scrollView.contentOffset.x;
    int page=(offset+MAINSCREENWIDTH/2)/MAINSCREENWIDTH;
        self.pageControl.currentPage=page;
    }
}

-(void)setStoreArray{
    StoreModel *storeModel1=[[StoreModel alloc]init];  //初始化模型，有五个单元格，所以初始化五个StoreModel的实例
    storeModel1.storePhotoName=@"福字";
    storeModel1.storeName=@"福记饮料配送";
    storeModel1.storeDistance=@"距您0.72千米";
    storeModel1.storeDeliveryCost=@"配送费 ¥5.0";
    
    StoreModel *storeModel2=[[StoreModel alloc]init];
    storeModel2.storePhotoName=@"福字";
    storeModel2.storeName=@"诚信粮油";
    storeModel2.storeDistance=@"距您2.24千米";
    storeModel2.storeDeliveryCost=@"配送费 ¥5.0";
    
    StoreModel *storeModel3=[[StoreModel alloc]init];
    storeModel3.storePhotoName=@"福字";
    storeModel3.storeName=@"新竹市场君怡酒店特菜配送";
    storeModel3.storeDistance=@"距您0.52千米";
    storeModel3.storeDeliveryCost=@"配送费 ¥20.0";
    
    StoreModel *storeModel4=[[StoreModel alloc]init];
    storeModel4.storePhotoName=@"福字";
    storeModel4.storeName=@"飞扬新城粮油干货酒店食材";
    storeModel4.storeDistance=@"距您7.62千米";
    storeModel4.storeDeliveryCost=@"配送费 ¥8.0";
    
    StoreModel *storeModel5=[[StoreModel alloc]init];
    storeModel5.storePhotoName=@"福字";
    storeModel5.storeName=@"兴业干调";
    storeModel5.storeDistance=@"距您9.8千米";
    storeModel5.storeDeliveryCost=@"配送费 ¥0.0";
    
    _storeArray=[[NSMutableArray alloc]initWithObjects:storeModel1,storeModel2,storeModel3,storeModel4,storeModel5, nil];
    
}

-(void)setFoodArray{
        
    FoodModel *food1 = [[FoodModel alloc] init];
    food1.foodPhotoName = @"icon_grain-and-oil";
    food1.foodName = @"粮油";
    FoodModel *food2 = [[FoodModel alloc] init];
    food2.foodPhotoName = @"icon_vegetables";
    food2.foodName = @"蔬菜";
    FoodModel *food3 = [[FoodModel alloc] init];
    food3.foodPhotoName = @"icon_seasoning";
    food3.foodName = @"调料干货";
    FoodModel *food4 = [[FoodModel alloc] init];
    food4.foodPhotoName = @"icon_egg";
    food4.foodName = @"肉禽蛋";
    FoodModel *food5 = [[FoodModel alloc] init];
    food5.foodPhotoName = @"icon_fish";
    food5.foodName = @"水冻产品";
    FoodModel *food6 = [[FoodModel alloc] init];
    food6.foodPhotoName = @"icon_dishware";
    food6.foodName = @"餐具饮料";
    FoodModel *food7 = [[FoodModel alloc] init];
    food7.foodPhotoName = @"icon_drink";
    food7.foodName = @"酒水饮料";
    FoodModel *food8 = [[FoodModel alloc] init];
    food8.foodPhotoName = @"icon_fruit";
    food8.foodName = @"水果";
    
    _foodArray=[[NSMutableArray alloc]initWithObjects:food1,food2,food3,food4,food5,food6,food7,food8, nil];
    
}

-(void)setActivityModel{
    self.activityModel=[[ActivityModel alloc]init];
    self.activityModel.activityPhoto1=@"pic_banner1.png";
    self.activityModel.activityPhoto2=@"pic_banner2.png";
    self.activityModel.activityName1=@"特价活动";
    self.activityModel.activityName2=@"免配送费";
    self.activityModel.activityDetail1=@"爆款、全市最低价";
    self.activityModel.activityDetail2=@"免费送菜啦";
    
}

-(NSInteger)numbersOfSectionInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _foodArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FoodCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    [cell setModel:_foodArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0&&indexPath.section==0)
//        return 230;
//    else if (indexPath.row==0&&indexPath.section==1)
        return 80;
    else
        return 120;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if(section==0)
//        return  1;
//    else if (section==1)
//        return 1;
//    else
//        return 5;
    if(section==0)
        return  1;
    else
        return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"identifier";
    
    if(indexPath.section==0){
        
        
        
        
//        FoodTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
//        if(cell==nil){
//            cell=[[FoodTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier withArray:_foodArray];
//        }
//       return cell;
//    }
    
//    else if(indexPath.section==1){
        ActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell==nil){
            cell=[[ActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setActivityModel:self.activityModel];
        return cell;
        }
    else{
        StoreTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell==nil){
            cell=[[StoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
       
        }
        [cell setStoreModel:_storeArray[indexPath.row]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
