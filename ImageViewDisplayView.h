//
//  ImageViewDisplayView.h
//  11111
//
//  Created by qiqi on 16/1/24.
//  Copyright © 2016年 qiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "photoScrollModel.h"
//点击图片的Block回调，参数当前图片的索引，也就是当前页数
typedef void(^TapImageViewBolck)(NSInteger imageIndex);

@interface ImageViewDisplayView : UIView

@property (nonatomic, strong)UIImageView *photoView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)photoScrollModel *photoModel;

@property (nonatomic, strong)NSArray *modelArray;// 接收model的数组

+ (instancetype)ImageViewDisplayViewWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame;

/**********************************
 *功能：为每个图片添加点击事件（例如点击图片进入详情页面）
 *参数：点击按钮要执行的Block
 *返回值：无
 **********************************/
- (void)addTapEventForImageWithBlock: (TapImageViewBolck)block;
@end
