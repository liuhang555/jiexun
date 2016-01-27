//
//  ProductListTableViewCell.m
//  Jiexun
//
//  Created by skma on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ProductListTableViewCell.h"

@interface ProductListTableViewCell ()

/**
 * 图片imageView
 **/
@property (nonatomic, strong) UIImageView *iconView;

/**
 * 分类名
 **/
@property (nonatomic, strong) UILabel *nameLable;


@end

@implementation ProductListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 图标
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(sWIDTH / 10, self.bounds.size.height / 4, sHEIGHT / 14, sHEIGHT / 14)];
        _iconView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_iconView];
        // 分类名
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(sWIDTH / 4 + 10, _iconView.frame.origin.y + 10, 100, 20)];
        _nameLable.font = F15;
        [self.contentView addSubview:_nameLable];
        
        // 品牌
        self.brandLable = [[UILabel alloc]initWithFrame:CGRectMake(_nameLable.frame.origin.x, _iconView.frame.origin.y + 30, sWIDTH / 2, 20)];
        _brandLable.alpha = 0.8;
        _brandLable.font = F13;
        [self.contentView addSubview:_brandLable];
        
    }
    return self;
}

- (void)display:(NSArray *)array name:(NSString *)name{
    _nameLable.text = name;
    if (array.count == 3) {
        _brandLable.text = [NSString stringWithFormat:@"%@ %@ %@", array[0], array[1], array[2]];
    }
    if (array.count == 2) {
        _brandLable.text = [NSString stringWithFormat:@"%@ %@", array[0], array[1]];
    }

}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
