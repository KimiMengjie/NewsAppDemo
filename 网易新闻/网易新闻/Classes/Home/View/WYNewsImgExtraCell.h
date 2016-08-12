//
//  WYNewsImgExtraCell.h
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYNewsImgExtraCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

//IBOutletCollection将多个控件拖到一个数组里面去
@property (nonatomic,strong)IBOutletCollection(UIImageView) NSArray *imgExtra;

@end
