//
//  WYHomeViewController.m
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import "WYHomeViewController.h"
#import "WYChannelView.h"
#import "WYNewsController.h"
#import "WYChannelModel.h"

static NSString *infoCell = @"infoCell";

@interface WYHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WYChannelViewDelegate>
/**
 *  频道的视图
 */

@property (nonatomic,strong)WYChannelView *channelView;
/**
 *  显示新闻的collectionView
 */

@property (nonatomic,weak)UICollectionView *collectionView;
/**
 *  记录频道的数据
 */
@property (nonatomic,strong)NSArray *channels;
/**
 *  控制器缓存
 */
@property (nonatomic,strong)NSMutableDictionary *vcCache;

@property (nonatomic,weak)UIView *adView;

@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    //获取模型数据
    [WYChannelModel channels];
    
    //添加边缘手势
    UIScreenEdgePanGestureRecognizer *ges = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(showAd:)];
    //必须设置边缘滑动
    ges.edges = UIRectEdgeLeft;
    //添加到View
    [self.view addGestureRecognizer:ges];
    // 如果ges的手势与collectionView手势都识别的话,指定以下代码,代表是识别传入的手势
    [self.collectionView.panGestureRecognizer requireGestureRecognizerToFail:ges];
    

}

- (void)showAd:(UIScreenEdgePanGestureRecognizer *)ges
{
    //让View跟着手指移动
    //frame的x？手指的位置？
    //获取手指位置
    CGPoint p = [ges locationInView:self.view];
    //获取ADframe不能直接修改
    CGRect frame = self.adView.frame;
    frame.origin.x = p.x - [UIScreen mainScreen].bounds.size.width;
    //重新设置
    self.adView.frame = frame;
    
    //当手指拖动结束和取消得到时候，判断位置是否弹回，还是满屏
    if (ges.state == UIGestureRecognizerStateEnded || ges.state == UIGestureRecognizerStateCancelled) {
        //判断屏幕，是否超过一半
        if (CGRectContainsPoint(self.view.frame, self.adView.center)) {
            //如果超过就完全显示
            frame.origin.x = 0;
        }else{
            //如果没有，隐藏
            frame.origin.x = - [UIScreen mainScreen].bounds.size.width;
        }
        [UIView animateWithDuration:.2 animations:^{
            self.adView.frame = frame;
        }];
    }
    
    
}

- (void)setupUI
{
    /**
     *  添加头条
     */
    //关闭自动调整内容位置。
    self.automaticallyAdjustsScrollViewInsets = false;
    
    WYChannelView *channelView = [WYChannelView channelView];
    
    //读取频道数据显示到界面,从模型中获取数据
    self.channels =[WYChannelModel channels];
    channelView.channels = self.channels;
    self.channelView =channelView;
    //加入子视图
    [self.view addSubview:channelView];
    
    [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(35);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
    [self setupCollectionView];
    [self setupAdView];
    
    //设置channelView的代理
    channelView.delegate = self;
  
}

/**
 *  添加广告
 */
- (void)setupAdView{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置背景颜色
    view.backgroundColor = [UIColor randomColor];
    
    //设置fram
    CGRect frame = view.frame;
    //先将图片隐藏
    frame.origin.x = -view.frame.size.width;
    
    //设置view
    view.frame = frame;
    //将view盖到Window上
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    self.adView = view;
    
    //添加轻扫手势
    UISwipeGestureRecognizer *ges = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(closeAd)];
    
    //添加手势方向和view
    ges.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.adView addGestureRecognizer:ges];
}

- (void)closeAd{
    [UIView animateWithDuration:.2 animations:^{
        CGRect frame = self.adView.frame;
        frame.origin.x = - [UIScreen mainScreen].bounds.size.width;
        self.adView.frame = frame;
    }];
}

/**
 下半部分，添加一个collectionView
 */
- (void)setupCollectionView{
    //创建一个layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置行间距和列间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    //初始化一个collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    //设置背景颜色
    collectionView.backgroundColor = [UIColor whiteColor];
    //取消滚动条
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.showsHorizontalScrollIndicator = false;
    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:infoCell];
    //设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //设置分页
    collectionView.pagingEnabled = true;
    
    //记录当前collectionView
    self.collectionView = collectionView;
    //加入到视图
    [self.view addSubview:collectionView];
    
    //添加约束
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.channelView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        //tabBar的top，此处约束应该这么设置
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    //此方法也能正常显示
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        flowLayout.itemSize = self.collectionView.frame.size;
//    });

}
/**
 *  控制器中的视图布局完成之后会调用这个方法，此方法在布局完成后调用一次，而不是在cell设置完成后调用
 */
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //取得layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    //设置size,itemSize是layout的属性,大小是collectionView大小
    layout.itemSize = self.collectionView.frame.size;
//    NSLog(@"%@",NSStringFromCGRect(self.collectionView.frame));
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:infoCell forIndexPath:indexPath];
    //先移除cell中的contentView的子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //取得模型
    WYChannelModel *model = self.channels[indexPath.item];
    //将新闻列表的控制的view添加到cell的contentView中
    //首先创建控制器
    UIViewController *vc = [self viewControllerWithModel:model];
    //加入控制器
    [cell.contentView addSubview:vc.view];
    //设置约束
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];

    return cell;
}

- (UIViewController *)viewControllerWithModel:(WYChannelModel *) model
{
    //如果已经存在，从缓存中取得控制器
    UIViewController *vc = [self.vcCache objectForKey:model.tid];
    
    //如果没有，那么先加载数据,并创建控制器
    if (!vc) {
        vc = [[WYNewsController alloc]initWithModel:model];
        //记得将VC放入缓存中
        [self.vcCache setObject:vc forKey:model.tid];
    }
    return vc;
}

#pragma mark - UICollectionViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取滑动比例
    CGFloat radio = scrollView.contentOffset.x / scrollView.frame.size.width;
    NSLog(@"%f",radio);
    
    //取得当前页面的索引，即他的整数部分
    NSInteger index = radio / 1;
    
    //根据滚动比例求出缩放比例,即小数部分
    CGFloat scale = radio - index;
    //防止越界
    if (index + 1 < self.channels.count) {
        //设置下一页的缩放比例
        [self.channelView setScale:scale forIndex:index + 1];
        //设置上一页的缩放比例
        [self.channelView setScale:1-scale forIndex:index]; 
    }

}

#pragma mark - 懒加载
-(NSMutableDictionary *)vcCache
{
    if (!_vcCache) {
        _vcCache = [NSMutableDictionary dictionary];
    }
    
    return _vcCache;
}

#pragma mark - WYChannelViewDelegate

- (void)changeView:(WYChannelView *)channelView clickWithIndex:(NSInteger)index
{
    NSLog(@"点击%zd",index);
    //设置点击位置，手动指定cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    //让collectionView滚到指定的cell
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    
}
@end
