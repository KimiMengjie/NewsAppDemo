//
//  WYNewsController.m
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import "WYNewsController.h"
#import "WYNetWorkManager.h"
#import "WYNewsModel.h"
#import "WYNewsBaseCell.h"

@interface WYNewsController ()<UITableViewDataSource>

@property (nonatomic,strong)NSArray *newsList;

@property (nonatomic,weak)UITableView *tableView;

@end

static NSString *normalCellid = @"normalCell";
static NSString *imgExtraCellid = @"imgExtraCell";
static NSString *bigImgCellid = @"bigImgCell";

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
    //    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [tableView registerNib:[UINib nibWithNibName:@"WYNormalCell" bundle:nil] forCellReuseIdentifier:normalCellid];
    [tableView registerNib:[UINib nibWithNibName:@"WYNewsImgExtraCell" bundle:nil] forCellReuseIdentifier:imgExtraCellid];
    [tableView registerNib:[UINib nibWithNibName:@"WYNewsBigImgCell" bundle:nil] forCellReuseIdentifier:bigImgCellid];
    //添加数据源方法
    tableView.dataSource = self;
    //将tableView添加到当前视图当中
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //设置自动行高,注意自动行高，需要设置与底部的边距
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100;
    
    //自动布局
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取得模型
    WYNewsModel *model = self.newsList[indexPath.row];
    
    NSString *reuseID = normalCellid;
    //判断内容取不同的cell
    if (model.imgextra.count > 0) {
        reuseID = imgExtraCellid;
    }else if (model.imgType){
        reuseID = bigImgCellid;
    }
    
    WYNewsBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    cell.model = model;
    
    return cell;
}
/**
 尽量不要在控制器里面直接去使用AFN.把afn使用我们自己的代码包装层.
 如果以后要换网络请求的框架,那么只需要更改我们包装的那一层就可以了
 如果直接在控制器里面使用AFN的话,在真实开发过程中,一个app有几十个界面.每个界面都去改很麻烦
 */
#pragma mark - 数据加载
- (void)loadData{
    
    NSString *tid = @"T1348649079062";
    
    [[WYNetWorkManager sharedNetWorkManager] getHomeNewListWithChannelID:tid completion:^(id response, NSError *error) {
//        NSLog(@"%@",response);
        //取到频道id对应的数据，使用yymodel字典转模型
        NSArray *array = [NSArray yy_modelArrayWithClass:[WYNewsModel class] json:response[tid]];
        
        self.newsList = array;
        
        //重新刷新数据
        [self.tableView reloadData];
    }];
}


@end
