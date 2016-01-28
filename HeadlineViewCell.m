

//
//  HeadlineViewCell.m
//  Jiexun
//
//  Created by qiqi on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HeadlineViewCell.h"
#import "UIImageView+WebCache.h"
@implementation HeadlineViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, sWIDTH / 3 - 20, 80)];
       
        [self.contentView addSubview:self.photoView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(sWIDTH / 3 + 5, 10, sWIDTH * 2 / 3 - 20, self.photoView.frame.size.height * 2 / 3)];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        self.pubDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(sWIDTH / 2, 70, sWIDTH / 7, 20)];
        self.pubDateLabel.font = F13;
        self.pubDateLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.pubDateLabel];
        
        self.cmtCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(sWIDTH * 5 / 6, 70, sWIDTH / 7, 20)];
        self.cmtCountLabel.font = F13;
         self.cmtCountLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.cmtCountLabel];
    }
    return self;
}

- (void)configureCellWithModel:(CellModel *)cellModel{
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:cellModel.image] placeholderImage:nil];
    self.titleLabel.text = cellModel.title;
    self.pubDateLabel.text = cellModel.pubDate;
    self.cmtCountLabel.text = [NSString stringWithFormat:@"评论：%ld",cellModel.cmtCount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
