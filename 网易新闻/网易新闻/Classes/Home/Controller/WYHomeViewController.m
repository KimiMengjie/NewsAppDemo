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
    WYChannelView *channelView = [WYChannelView channelView];
    //加入子视图
    [self.view addSubview:channelView];
    
    [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(35);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
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
