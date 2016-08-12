//
//  WYNewsController.m
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import "WYNewsController.h"
#import "WYNetWorkManager.h"

@interface WYNewsController ()<UITableViewDataSource>

@end

@implementation WYNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self loadData];
}

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc]init];
    
    //注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    //添加数据源方法
    tableView.dataSource = self;
    //将tableView添加到当前视图当中
    [self.view addSubview:tableView];
    
    //自动布局
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    //测试数据
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}
/**
 尽量不要在控制器里面直接去使用AFN.把afn使用我们自己的代码包装层.
 如果以后要换网络请求的框架,那么只需要更改我们包装的那一层就可以了
 如果直接在控制器里面使用AFN的话,在真实开发过程中,一个app有几十个界面.每个界面都去改很麻烦
 */
#pragma mark - 数据加载
- (void)loadData{
    [[WYNetWorkManager sharedNetWorkManager] getHomeNewListWithChannelID:@"T1348649079062" completion:^(id response, NSError *error) {
        NSLog(@"%@",response);
    }];
}


@end
