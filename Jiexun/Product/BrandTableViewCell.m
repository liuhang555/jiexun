//
//  BrandTableViewCell.m
//  Jiexun
//
//  Created by skma on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BrandTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface BrandTableViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLable;

@end

@implementation BrandTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView =[[UIImageView alloc]initWithFrame:CGRectMake(10, sHEIGHT / 32, sWIDTH / 5, sHEIGHT / 16)];
        [self.contentView addSubview:_iconView];
//        _iconView.backgroundColor = [UIColor redColor];
        
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(sWIDTH / 4 + 20, self.bounds.size.height / 2 + 10, sWIDTH / 4, 20)];
        [self.contentView addSubview:_nameLable];
//        _nameLable.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)getUrl:(NSString *)url name:(NSString *)name{
    _nameLable.text = name;
    if (url != nil) {
        [_iconView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"back"]];
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
