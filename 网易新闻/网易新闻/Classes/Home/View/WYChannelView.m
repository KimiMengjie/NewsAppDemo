//
//  WYChannelView.m
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import "WYChannelView.h"

@implementation WYChannelView

+ (instancetype)channelView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WYChannelView" owner:nil options:nil] lastObject];
}

@end
