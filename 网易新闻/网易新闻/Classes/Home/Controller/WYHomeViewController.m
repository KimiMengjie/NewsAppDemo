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


@interface WYHomeViewController ()

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
    channelView.channels = [WYChannelModel channels];
    //加入子视图
    [self.view addSubview:channelView];
    
    [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(35);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
    /**
     下半部分
     */
    WYNewsController *vc = [[WYNewsController alloc]init];
    
    UIView *view = vc.view;
    
    [vc.view setBackgroundColor:[UIColor redColor]];
    [self addChildViewController:vc];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:channelView];
    
    //自动布局
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(channelView.mas_bottom);
        make.left.right.offset(0);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

@end
