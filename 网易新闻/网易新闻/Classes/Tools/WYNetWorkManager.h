//
//  WYNetWorkManager.h
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


//继承自AFHTPPSeesionManager为了以后如果要替换网络框架
@interface WYNetWorkManager : AFHTTPSessionManager

/**
 *  全局访问点，网络管理是个单例
 */

+ (instancetype)sharedNetWorkManager;

/**
 *  GET请求
 *
 *  @param urlString  请求地址
 *  @param parameters 请求参数
 *  @param completion 请求完成后的回调
 */
//- (void)getWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(void(^)(id response, NSError *error)) completion;

/**
 *  获取首页新闻页面
 *
 *  @param channelID  频道ID
 *  @param completion 获取数据后的回调
 */
- (void)getHomeNewListWithChannelID:(NSString *)channelID completion:(void(^)(id response, NSError *error)) completion;
@end
