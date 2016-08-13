//
//  WYChannelView.h
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYChannelView : UIView
/**
 *  频道模型
 */
@property (nonatomic,strong)NSArray *channels;

+ (instancetype)channelView;

@end
