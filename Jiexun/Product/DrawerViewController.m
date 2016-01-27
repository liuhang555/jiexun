//
//  DrawerViewController.m
//  Jiexun
//
//  Created by skma on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DrawerViewController.h"


@interface DrawerViewController () <UIGestureRecognizerDelegate>



@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 左View
    self.leftView = [[LeftView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_leftView];
    // 右View
    self.rightView = [[RightView alloc]initWithFrame:CGRectMake(sWIDTH, 0, sWIDTH * 3 / 4, sHEIGHT)];
    [self.view addSubview:_rightView];
    // 测试button
//    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doTip:)];
//    self.navigationItem.leftBarButtonItem = button;
    
    self.panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(doDraw:)];
    _panGR.delegate = self;
    [self.rightView addGestureRecognizer:_panGR];
//    [self.view bringSubviewToFront:_leftView];
  
    
}

- (void)doTip//:(UIButton *)button{
    {
    [UIView animateWithDuration:0.5 delay:0 options:2 animations:^{
        self.rightView.center = CGPointMake(sWIDTH * 5 / 8, sHEIGHT / 2);
        self.leftView.center = CGPointMake(sWIDTH / 2 - sWIDTH / 4, sHEIGHT / 2);
    } completion:nil];
     self.rightCenter = _rightView.center;
    self.leftCenter = _leftView.center;
    
}


- (void)doDraw:(UIPanGestureRecognizer *)panGR{
    
    CGPoint trans = [_panGR translationInView:_rightView];
    if (trans.x > 0) {
        if (_panGR.state == UIGestureRecognizerStateCancelled || panGR.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.2 delay:0 options:2 animations:^{
                if (_rightView.frame.origin.x > sWIDTH * 2 / 3) {
                    self.leftView.center = CGPointMake(sWIDTH / 2, sHEIGHT / 2);
                    self.rightView.center = CGPointMake(sWIDTH + sWIDTH / 2, sHEIGHT / 2);
                }else{
                    self.rightView.center = CGPointMake(sWIDTH * 5 / 8, sHEIGHT / 2);
                    self.leftView.center = CGPointMake(sWIDTH / 2 - sWIDTH / 4, sHEIGHT / 2);
                }
            } completion:nil];
        }else{
            self.rightView.center = CGPointMake(_rightCenter.x + trans.x, sHEIGHT / 2);
            self.leftView.center = CGPointMake(_leftCenter.x + trans.x * 3 / 14, sHEIGHT / 2);
        }
    }
       
    NSLog(@"%.2f", trans.x);
    NSLog(@"我被抓了");
}





- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
