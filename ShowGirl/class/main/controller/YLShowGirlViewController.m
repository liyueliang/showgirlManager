//
//  YLShowGirlViewController.m
//  ShowGirl
//  展示美女图片列表
//  Created by lyl on 15/7/4.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLShowGirlViewController.h"
#import "YLImageModal.h"
#import "YLImgCell.h"
#import "YLClearGirlViewController.h"
#import "MobClick.h"
#import "GDTMobBannerView.h"
#import "YLImgHeadViewReusableView.h"
#define cellIdentity @"girlCell"
#define headCellIdentity @"girlHeadCell"
#define bottomCellIdentity @"girlFooterCell"
@interface YLShowGirlViewController ()<GDTMobBannerViewDelegate>
{
   GDTMobBannerView *_bannerViewOfHead;//声明一个GDTMobBannerView的实例
    GDTMobBannerView *_bannerViewOfBottom;//声明一个GDTMobBannerView的实例
}
@property(nonatomic,strong) NSMutableArray *imgData;
@end

@implementation YLShowGirlViewController
-(instancetype)init{
    
    if (self =[super initWithCollectionViewLayout:[self setupCollectionLayoutDetail]]) {
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //友盟统计页面展示
    [MobClick beginLogPageView:@"YLShowGirl"];
    //检测是否关闭广告
    //[self updateBannerView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //友盟统计页面展示
    [MobClick endLogPageView:@"YLShowGirl"];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
   
 

    
    //注册cell
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentity];
    UINib *nib =[UINib nibWithNibName:@"YLImgCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:cellIdentity];
    
    //注册头部视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headCellIdentity];
    //注册底部视图
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:bottomCellIdentity];
    //添加广告
    _bannerViewOfHead =  [self createBannerView];
    _bannerViewOfBottom = [self createBannerView];
}
///**
// *  根据设置->根据广告开关管理来是否显示广告
// */
//-(void)updateBannerView{
//    NSUserDefaults *userDefautls =[NSUserDefaults standardUserDefaults];
//    if ([userDefautls objectForKey:@"ad_manager"]) {
//        BOOL gd_truenOn =[[userDefautls objectForKey:@"ad_manager"] boolValue];
//        if (gd_truenOn==NO) {
//            if (_bannerView) {
//                _bannerView.frame=CGRectZero;
//            }
//        }else{
//            if (_bannerView==nil) {
//                [self createBannerView];
//            }
//        }
//    }
//}

/*
 * 创建Banner广告View
 * "appkey" 指在 http://e.qq.com/dev/ 能看到的app唯一字符串
 * "placementId" 指在 http://e.qq.com/dev/ 生成的数字串，广告位id
 *
 * banner条广告，广点通提供如下3中尺寸供开发者使用
 * 320*50 适用于iPhone
 * 468*60、728*90适用于iPad
 * banner条的宽度开发者可以进行手动设置，用以满足开发场景需求或是适配最新版本的iphone
 * banner条的高度广点通侧强烈建议开发者采用推荐的高度，否则显示效果会有影响
 *
 * 这里以320*50为例
 */

-(GDTMobBannerView *)createBannerView{
    
    GDTMobBannerView *_bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, 0,
                                                                     GDTMOB_AD_SUGGEST_SIZE_320x50.width,
                                                                     GDTMOB_AD_SUGGEST_SIZE_320x50.height)
                                                   appkey:@"1104755080"
                                              placementId:@"1000109489504748"];
    
    _bannerView.delegate = self; // 设置Delegate
    _bannerView.currentViewController = self; //设置当前的ViewController
    _bannerView.interval = 5; //【可选】设置刷新频率;默认30秒
    _bannerView.isGpsOn = NO; //【可选】开启GPS定位;默认关闭
    _bannerView.showCloseBtn = YES; //【可选】展示关闭按钮;默认显示
    _bannerView.isAnimationOn = YES; //【可选】开启banner轮播和展现时的动画效果;默认开启
    //[self.view addSubview:_bannerView]; //添加到当前的view中
    [_bannerView loadAdAndShow]; //加载广告并展示
    return _bannerView;
}
-(NSMutableArray *)imgData{
    if (_imgData==nil) {
        _imgData=[NSMutableArray array];
        NSArray *plistArray =[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"girlData" ofType:@"plist"]];
        for (NSDictionary *item in plistArray) {
            YLImageModal *imgItem =[YLImageModal imageModalWithDict:item];
            YLLog(@"%@",imgItem);
            [_imgData addObject:imgItem];
        }
    }
    return _imgData;
}
-(UICollectionViewFlowLayout *)setupCollectionLayoutDetail{
    //1:流水布局
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    //计算cell的宽度(屏幕尺寸-左右间距-每个cell的水平间距)
    CGFloat marginOfLeft =1;
    CGFloat marginOfRight =1;
    CGFloat marginOfTop = 1;
    CGFloat marginOfBottom =1;
    CGFloat marginOfCellH =3;
    CGFloat marginOfCellV =3;
    int columnCount =3 ;
    CGFloat screenW =  [[UIScreen mainScreen]bounds].size.width;
    CGFloat itemW = (screenW-marginOfLeft-marginOfRight-columnCount*marginOfCellH)/columnCount;
    //2:设置cell的尺寸
    flowLayout.itemSize = CGSizeMake(itemW, 150);
    //3:设置cell水平间距
    flowLayout.minimumInteritemSpacing= marginOfCellH;
    //4:设置cell垂直间距
    flowLayout.minimumLineSpacing=marginOfCellV;
    //5:设置上下左右的间距 (上，左，下，右)
    flowLayout.sectionInset=UIEdgeInsetsMake(marginOfTop, marginOfLeft, marginOfBottom, marginOfRight);
    //设置head
    flowLayout.headerReferenceSize=CGSizeMake([[UIScreen mainScreen] bounds].size.width, 0);
    //设置footer
    flowLayout.footerReferenceSize =flowLayout.headerReferenceSize;
    return flowLayout;
}
#pragma mark - collectionView datasoure
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YLImgCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentity forIndexPath:indexPath];

    cell.imageModal = [self.imgData objectAtIndex:indexPath.row];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind==UICollectionElementKindSectionHeader) {//头部
        reusableview =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headCellIdentity forIndexPath:indexPath];
        [reusableview addSubview:_bannerViewOfHead];
    }else if(kind==UICollectionElementKindSectionFooter){//底部
        reusableview =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:bottomCellIdentity forIndexPath:indexPath];
        [reusableview addSubview:_bannerViewOfBottom];
    }
    return reusableview;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YLImageModal *currentModal = (YLImageModal *)[self.imgData objectAtIndex:indexPath.row];
    YLClearGirlViewController *clearGirlVC  =[[YLClearGirlViewController alloc]init];
    clearGirlVC.imageModal =currentModal;
    [self presentModalViewController:clearGirlVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -bannerview delegate
// 请求广告条数据成功后调用
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)bannerViewDidReceived
{
    YLLog(@"%s",__FUNCTION__);
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.headerReferenceSize=CGSizeMake([[UIScreen mainScreen] bounds].size.width, GDTMOB_AD_SUGGEST_SIZE_320x50.height);
    flowLayout.footerReferenceSize=flowLayout.headerReferenceSize;
}

// 请求广告条数据失败后调用
//
// 详解:当接收服务器返回的广告数据失败后调用该函数
- (void)bannerViewFailToReceived:(NSError *)error
{
    YLLog(@"%s, Error:%@",__FUNCTION__,error);
    
    
}

// 应用进入后台时调用
//
// 详解:当点击下载或者地图类型广告时，会调用系统程序打开，
// 应用将被自动切换到后台
- (void)bannerViewWillLeaveApplication
{
    YLLog(@"%s",__FUNCTION__);
}

// banner条曝光回调
//
// 详解:banner条曝光时回调该方法
- (void)bannerViewWillExposure
{
    YLLog(@"%s",__FUNCTION__);
}

// banner条点击回调
//
// 详解:banner条被点击时回调该方法
- (void)bannerViewClicked
{
    YLLog(@"%s",__FUNCTION__);
}

/**
 *  banner条被用户关闭时调用
 *  详解:当打开showCloseBtn开关时，用户有可能点击关闭按钮从而把广告条关闭
 */
- (void)bannerViewWillClose
{
    YLLog(@"%s",__FUNCTION__);
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.headerReferenceSize=CGSizeMake([[UIScreen mainScreen] bounds].size.width, 0);
    flowLayout.footerReferenceSize=flowLayout.headerReferenceSize;
}

@end
