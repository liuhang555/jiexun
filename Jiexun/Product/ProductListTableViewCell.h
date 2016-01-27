//
//  ProductListTableViewCell.h
//  Jiexun
//
//  Created by skma on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListTableViewCell : UITableViewCell

/**
 * 品牌lable
 **/
@property (nonatomic, strong) UILabel *brandLable;

/**
 * 赋值显示操作
 **/
- (void)display:(NSArray *)array name:(NSString *)name;

@end
