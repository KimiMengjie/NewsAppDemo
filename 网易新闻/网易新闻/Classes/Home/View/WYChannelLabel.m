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
    WYChannelLabel *label = [[self alloc]labelWithText:model.tname textColor:[UIColor blackColor] fontSize:kLabelMaxSizeFont];
    //根据内容调整大小
    [label sizeToFit];
    
    //计算字号为18号的大小之后，再把字体转换成14号，防止放大后太大，溢出
    label.font = [UIFont systemFontOfSize:kLabelMinSizeFont];
    
    return label;
}

- (instancetype)labelWithText:(NSString*)text textColor:(UIColor*)textColor fontSize:(CGFloat)fontSize
{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    
    return label;
}

@end
