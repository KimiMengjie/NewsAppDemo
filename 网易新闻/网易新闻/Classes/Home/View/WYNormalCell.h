//
//  WYNormalCell.h
//  网易新闻
//
//  Created by kimi on 16/8/12.
//  Copyright © 2016年 kimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYNormalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replayCountLabel;

@end
