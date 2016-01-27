//
//  DrawerViewController.h
//  Jiexun
//
//  Created by skma on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftView.h"
#import "RightView.h"

@interface DrawerViewController : UIViewController

/**
 * 左面侧边栏
 **/
@property (nonatomic, strong) LeftView *leftView;

/**
 * 右面View
 **/
@property (nonatomic, strong) RightView *rightView;

/**
 * 拖拽手势
 **/
@property (nonatomic, strong) UIPanGestureRecognizer *panGR;

/**
 * 左边view的center
 **/
@property (nonatomic) CGPoint rightCenter;

/**
 * 右边view的ceter
 **/
@property (nonatomic) CGPoint leftCenter;

/**
 * 点击事件方法
 **/
- (void)doTip;//:(UIButton *)button;


@end
