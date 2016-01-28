//
//  ItemScrollView.m
//  Jiexun
//
//  Created by qiqi on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "ItemScrollView.h"

@implementation ItemScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lable1 = [[UILabel alloc] init];
        UILabel *lable2 = [[UILabel alloc] init];
        UILabel *lable3 = [[UILabel alloc] init];
        UILabel *lable4 = [[UILabel alloc] init];
        UILabel *lable5 = [[UILabel alloc] init];
        UILabel *lable6 = [[UILabel alloc] init];
        UILabel *lable7 = [[UILabel alloc] init];
        UILabel *lable8 = [[UILabel alloc] init];
        UILabel *lable9 = [[UILabel alloc] init];
        NSArray *arr = @[@"头条",@"Apple",@"新闻",@"评测",@"手机",@"视听",@"笔记本",@"平板",@"图赏"];
        NSArray *array = @[lable1,lable2,lable3,lable4,lable5,lable6,lable7,lable8,lable9];
        for (int i = 0; i < 9; i++) {
            ((UILabel *)array[i]).frame = CGRectMake(0 + 60 * i, 20, 60, 40);
            ((UILabel *)array[i]).textColor = [UIColor whiteColor];
            ((UILabel *)array[i]).textAlignment = NSTextAlignmentCenter;
            ((UILabel *)array[i]).text = arr[i];
            [self addSubview:((UILabel *)array[i])];
            
        }
        
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
