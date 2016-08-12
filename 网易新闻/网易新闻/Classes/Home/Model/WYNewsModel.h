//
//  WYNewsModel.h
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYNewsModel : NSObject

/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 * 新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 * 图像 URL 地址
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 * 跟帖数量
 */
@property (nonatomic, copy) NSString *replyCount;
/**
 * 来源
 */
@property (nonatomic, copy) NSString *source;

/**
 * 多图新闻的其余图片
 */
@property (nonatomic, strong) NSArray *imgextra;

/**
 * 图片类型，如果等于1.代表是大图
 */
@property (nonatomic, assign) NSInteger imgType;


@end
