//
//  HeadlineViewCell.h
//  Jiexun
//
//  Created by qiqi on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"
@interface HeadlineViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *photoView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *cmtCountLabel;
@property (nonatomic, strong)UILabel *pubDateLabel;

- (void)configureCellWithModel:(CellModel *)cellModel;
@end
