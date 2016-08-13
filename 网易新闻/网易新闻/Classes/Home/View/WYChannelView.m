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
        
        //添加tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        
        //手势添加到label上
        [label addGestureRecognizer:tap];
        
        //开始用户交互
        label.userInteractionEnabled = true;
    }
    //设置显示范围
    [self.scrollView setContentSize:CGSizeMake(x, 35)];
    
    //初始的时候先给第0个label设置成红色
    [self setScale:1 forIndex:0];
}

#pragma mark - 手势监听
- (void)tapGesture:(UITapGestureRecognizer *)ges
{
    NSLog(@"%@",ges.view);
    //通过代理方法，告诉viewController被点击切换内容
    if ([self.delegate respondsToSelector:@selector(changeView:clickWithIndex:)]) {
        //获取点击的index
        [self.delegate changeView:self clickWithIndex:[self.scrollView.subviews indexOfObject:ges.view]];
    }
    //遍历如果是选中的话就把label放大，其他设置为0
    for (WYChannelLabel *label in self.scrollView.subviews) {
        label.scale = ges.view == label;
    }
}

- (void)setScale:(CGFloat)scale forIndex:(NSInteger)index
{
    
    //1.取得对应index的label
    WYChannelLabel *label = self.scrollView.subviews[index];
    //2.设置缩放比例
    label.scale = scale;
    
}



@end
