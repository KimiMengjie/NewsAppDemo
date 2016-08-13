//
//  WYChannelView.m
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import "WYChannelView.h"
#import "WYChannelModel.h"
#import "WYChannelLabel.h"

@interface WYChannelView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation WYChannelView

+ (instancetype)channelView {
    return [[[NSBundle mainBundle] loadNibNamed:@"WYChannelView" owner:nil options:nil] lastObject];
}

/**
 *  重写setter方法设置显示内容
 *
 *  @param channels 模型
 */
-(void)setChannels:(NSArray *)channels
{
    _channels = channels;
    //取消scrollView滚动
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    //设置每个label之间的间距
    CGFloat margin = 10;
    //设置左边初始距离
    CGFloat x = margin;
    
    for (int i = 0 ; i < channels.count; i++) {
        //取到频道的模型
        WYChannelModel *model = channels[i];
        //初始化label
//        UILabel *label = [[UILabel alloc]init];
//        label.text = model.tname;
//        label.textColor = [UIColor blackColor];
//        label.font = [UIFont systemFontOfSize:14];
//        [label sizeToFit];
       WYChannelLabel *label = [WYChannelLabel labelWithModel:model];
        //设置label位置
        label.frame = CGRectMake(x, 0, label.frame.size.width, 35);
        //将label加入到scrollView当中
        [self.scrollView addSubview:label];
        
        //X递增
        x += label.frame.size.width + margin;
    }
    //设置显示范围
    [self.scrollView setContentSize:CGSizeMake(x, 35)];
}


@end
