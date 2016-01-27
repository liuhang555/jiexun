//
//  BrandTableView.m
//  Jiexun
//
//  Created by skma on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BrandTableView.h"

@implementation BrandTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (style) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back"]];
    }
    return self;
}

@end
