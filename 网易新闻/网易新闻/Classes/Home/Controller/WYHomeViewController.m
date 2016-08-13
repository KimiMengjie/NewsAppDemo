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

@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    

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
        make.leading.trailing.bottom.equalTo(self.view);
    }];

}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:infoCell forIndexPath:indexPath];

    //设置随机颜色供测试
    cell.backgroundColor = [UIColor randomColor];
    

    
    return cell;
}

@end
