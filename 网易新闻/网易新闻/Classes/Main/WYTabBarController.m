//
//  WYTabBarController.m
//  网易新闻
//
//  Created by kimi on 8/12/16.
//  Copyright © 2016 kimi. All rights reserved.
//

#import "WYTabBarController.h"

@interface WYTabBarController ()

@end

@implementation WYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewControllers{
    NSArray *array = @[
                       @{@"clsName": @"WYNewsController", @"title": @"新闻", @"imageName": @"news"},
                       @{@"clsName": @"UIViewController", @"title": @"阅读", @"imageName": @"reader"},
                       @{@"clsName": @"UIViewController", @"title": @"视频", @"imageName": @"media"},
                       @{@"clsName": @"UIViewController", @"title": @"话题", @"imageName": @"bar"},
                       @{@"clsName": @"UIViewController", @"title": @"我", @"imageName": @"me"},
                       ];
    //遍历数组，添加子控制器
    for (NSDictionary *dict in array) {
        //创建控制器
        UIViewController *vc = [self viewControllerWithDict:dict];
        //加入子控制器
        [self addChildViewController:vc];
    }
}

/**
 *  通过字典去初始化控制器
 *
 *  @param dict 控制器名字典
 *
 *  @return 控制器
 */
- (UIViewController *)viewControllerWithDict:(NSDictionary *)dict{
    //1.初始化控制器
    UIViewController *vc = [NSClassFromString(dict[@"clsName"]) new];
    
    //2.设置title
    vc.title = dict[@"title"];
    //3.设置不同状态显示的图片
    
    vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon_%@_normal",dict[@"imageName"]]];
    //设置选中图片
    vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_icon_%@_highlight",dict[@"imageName"]]];
    
    
    //使用导航控制器包裹该控制器返回
    
    return [[UINavigationController alloc]initWithRootViewController:vc];
    
}

@end
