//
//  WYChannelView.h
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYChannelView;
@protocol WYChannelViewDelegate <NSObject>

- (void)changeView:(WYChannelView *)channelView clickWithIndex:(NSInteger)index;

@end

@interface WYChannelView : UIView
/**
 *  频道模型
 */
@property (nonatomic,strong)NSArray *channels;

@property (nonatomic,weak) id <WYChannelViewDelegate> delegate;



+ (instancetype)channelView;
/**
 *  设置指定索引的缩放比例
 *
 *  @param scale 比例0-1
 *  @param index 索引，缩放哪个label
 */
- (void)setScale:(CGFloat)scale forIndex:(NSInteger)index;
@end
