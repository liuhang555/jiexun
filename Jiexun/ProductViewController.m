//
//  ProductViewController.m
//  Jiexun
//
//  Created by skma on 16/1/26.
//  Copyright © 2016年 jiexun. All rights reserved.
//

#import "ProductViewController.h"


#import "ProductListTableViewCell.h"

#import "NetHandler.h"

@interface ProductViewController () <UITableViewDataSource, UITableViewDelegate>
/**
 * 分类列表字典
 **/
@property (nonatomic, strong) NSDictionary *PLListDic;

/**
 * 分类列表key数组
 **/
@property (nonatomic, strong) NSArray *PLListArray;

/**
 * 左侧栏tableView
 **/
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 创建左侧大的分组
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, sWIDTH, sHEIGHT - 64) style:UITableViewStylePlain];
    [self.leftView addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.rowHeight = sHEIGHT / 7;
    _tableView.delegate = self;
    self.leftView.backgroundColor = [UIColor whiteColor];

    [self PLNetworkRequest];
#pragma 添加观察者，观察rightView center的变化
    [self.rightView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
}

// 分类列表网络请求
- (void)PLNetworkRequest{
    [NetHandler getDataWithUrl:@"http://mrobot.pconline.com.cn/v3/product/brandNameTopv36" completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            if (dic != nil) {
                self.PLListDic = [NSDictionary dictionaryWithDictionary:dic];
                self.PLListArray = [dic allKeys];
            }
            [_tableView reloadData];
        }
    }];
}

// tableView的dataSource方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _PLListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reused = @"reuse";
    ProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reused];
    if (!cell) {
        cell = [[ProductListTableViewCell alloc]init];
    }
    
    if (_PLListDic != nil | _PLListArray.count != 0) {
        // 根据所在位置取值
        NSString *str = _PLListArray[indexPath.row];
        NSArray *array = _PLListDic[str];
        // cell调用赋值方法
        [cell display:array name:str];
    }
    return cell;
}

// 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self doTip];
    NSArray *cellArray = [tableView visibleCells];
    [UIView animateWithDuration:0.5 delay:0 options:2 animations:^{
        for (int i = 0; i < cellArray.count; i++) {
            [cellArray[i] brandLable].alpha = 0;
        }
    } completion:nil];
}

#pragma 观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    CGFloat centerX = self.rightView.center.x;
    
    NSArray *cellArray = [_tableView visibleCells];
    [UIView animateWithDuration:0.5 delay:0 options:2 animations:^{
        for (int i = 0; i < cellArray.count; i++) {
            [cellArray[i] brandLable].alpha = 0.8 * ((centerX - sWIDTH * 5 / 8) /( 3 * sWIDTH / 4));
            NSLog(@"alpha = %f", [cellArray[i] brandLable].alpha);
            NSLog(@"center = %ld", (long)centerX);
        }
    } completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.rightView removeObserver:self forKeyPath:@"center" context:nil];
}

@end
