//
//  WYChannelModel.h
//  网易新闻
//
//  Created by kimi on 8/13/16.
//  Copyright © 2016 kimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYChannelModel : NSObject

/**
 *  频道ID
 */
@property (nonatomic,copy) NSString *tid;
/**
 *  频道名字
 */
@property (nonatomic,copy) NSString *tname;
/**
 *  获取频道
 *
 *  @return 排序后的频道信息
 */
+ (NSArray *)channels;

@end
