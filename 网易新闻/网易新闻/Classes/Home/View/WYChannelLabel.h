//
//  WYChannelLabel.h
//  网易新闻
//
//  Created by kimi on 8/13/16.
//  Copyright © 2016 kimi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYChannelModel;
@interface WYChannelLabel : UILabel

/**
 *  创建头条label
 *
 *  @param model 模型数据
 *
 *  @return label
 */
+ (instancetype)labelWithModel:(WYChannelModel *)model;


@end
