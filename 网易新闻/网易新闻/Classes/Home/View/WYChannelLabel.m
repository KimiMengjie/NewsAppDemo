//
//  WYChannelLabel.m
//  网易新闻
//
//  Created by kimi on 8/13/16.
//  Copyright © 2016 kimi. All rights reserved.
//

#import "WYChannelLabel.h"
#import "WYChannelModel.h"

#define kLabelMaxSizeFont 18
#define kLabelMinSizeFont 14

@implementation WYChannelLabel

+ (instancetype)labelWithModel:(WYChannelModel *)model
{
    WYChannelLabel *label = [self labelWithText:model.tname textColor:[UIColor blackColor] fontSize:kLabelMaxSizeFont];
    //根据内容调整大小
    [label sizeToFit];
    
    //计算字号为18号的大小之后，再把字体转换成14号，防止放大后太大，溢出
    label.font = [UIFont systemFontOfSize:kLabelMinSizeFont];
    
    return label;
}

-(void)setScale:(CGFloat)scale
{
    _scale  = scale;
    //1.设置label的缩放比例
    [self setTextColor:[UIColor colorWithRed:scale green:0 blue:0 alpha:1]];
    
    //2.大->小
    /*
     14->0
     18->1
     */
    CGFloat sc = 14 + (18 - 14) *scale;
    //label自身缩放
    //增加动画
    [UIView animateWithDuration:.2 animations:^{
        self.transform = CGAffineTransformMakeScale(sc / 14, sc / 14);
    }];
    
}



@end
