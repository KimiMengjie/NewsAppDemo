//
//  WYNetWorkManager.m
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import "WYNetWorkManager.h"
#import <AFNetworking.h>

@implementation WYNetWorkManager

-(instancetype)sharedNetWorkManager
{
    static WYNetWorkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[WYNetWorkManager alloc] init];
    });
    
    return instance;
}

-(void)getWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(void (^)(id, NSError *))completion
{
    //因为继承自AFN所以可以调用父类方法
    [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //回调请求回来的数据，如果成功
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //回调失败的数据
        completion(nil,error);
    }];
    
}

#pragma mark - 获取首页的数据
-(void)getHomeNewListWithChannelID:(NSString *)channelID completion:(void (^)(id, NSError *))completion
{
    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/0-20.html", channelID];
    //调用GET请求接口,同时回调数据
    [self getWithURLString:urlString parameters:nil completion:completion];
}

@end
