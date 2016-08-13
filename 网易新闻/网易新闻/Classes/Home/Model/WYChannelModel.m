//
//  WYChannelModel.m
//  网易新闻
//
//  Created by kimi on 8/13/16.
//  Copyright © 2016 kimi. All rights reserved.
//

#import "WYChannelModel.h"

@implementation WYChannelModel

+ (NSArray *)channels
{
    //1.JSON路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    
    //2.获取临时字典(JSON需要先用NSData接收)
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //反序列化
    NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    //3.字典转模型,利用yymodel
    NSArray *result = [NSArray yy_modelArrayWithClass:[self class] json:tempDict[@"tList"]];
    
    //4.对包含模型的数组进行排序
     result = [result sortedArrayUsingComparator:^NSComparisonResult(WYChannelModel * _Nonnull obj1, WYChannelModel *  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    return result;
}

@end
