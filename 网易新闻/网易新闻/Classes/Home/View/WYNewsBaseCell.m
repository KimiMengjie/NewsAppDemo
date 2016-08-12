//
//  WYNewsBaseCell.m
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import "WYNewsBaseCell.h"
#import "WYNewsModel.h"

@interface WYNewsBaseCell ()

//一个IBoutlet的属性可以对应不通的xib控件
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;


//IBOutletCollection将多个控件拖到一个数组里面去
@property (nonatomic,strong) IBOutletCollection (UIImageView) NSArray *imgExtra;

@end

@implementation WYNewsBaseCell

- (void)setModel:(WYNewsModel *)model
{
    _model = model;
    //cell复用先清空图片
    if (self.imgExtra != nil) {
        self.imgExtra = nil;
    }
    //设置显示内容
    [self.imgsrcView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    //设置标题
    [self.titleLabel setText:model.title];
    //设置来源
    [self.sourceLabel setText:model.source];
    //设置跟贴数
    [self.replyCountLabel setText:model.replyCount];
    
    //当前遍历的索引idx
    [model.imgextra enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //给UIImageView赋值，这里obj是字典
        NSLog(@"%@",obj);
        UIImageView *imageView = self.imgExtra[idx];
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj[@"imgsrc"]]];
    }];
}

@end
