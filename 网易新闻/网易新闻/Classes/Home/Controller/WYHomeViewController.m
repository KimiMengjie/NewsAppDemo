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

@interface WYHomeViewController ()<UICollectionViewDataSource>
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

@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    //获取模型数据
    [WYChannelModel channels];

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
    //取消滚动条
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.showsHorizontalScrollIndicator = false;
    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:infoCell];
    //设置数据源
    collectionView.dataSource = self;
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

#pragma mark - 懒加载
-(NSMutableDictionary *)vcCache
{
    if (!_vcCache) {
        _vcCache = [NSMutableDictionary dictionary];
    }
    
    return _vcCache;
}

@end
