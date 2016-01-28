//
//  ProductViewController.m
//  Jiexun
//
//  Created by skma on 16/1/26.
//  Copyright © 2016年 jiexun. All rights reserved.
//

#import "ProductViewController.h"

/**
 *
 **/
#import "ProductListViewController.h"

/**
 *
 **/
#import "BrandTableView.h"

/**
 * 左边tableView的cell
 **/
#import "ProductListTableViewCell.h"

/**
 * 推荐品牌Model
 **/
#import "BrandM.h"

/**
 * 所有品牌Model
 **/
#import "TotalM.h"

/**
 * 网络请求
 **/
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

/**
 *
 **/
@property (nonatomic, strong) BrandTableView *brandTableView;

/**
 *
 **/
@property (nonatomic, strong) NSMutableArray *brandArray;
@property (nonatomic, strong) NSMutableArray *totalArray;
@property (nonatomic, strong) NSMutableDictionary *totalDic;
@property (nonatomic, strong) NSMutableArray *totalKeyArray;
@property (nonatomic, strong) NSDictionary *urlDic;
@property (nonatomic, copy) NSString *ID;

@end

@implementation ProductViewController

/**
 * 懒加载
 **/
- (NSMutableArray *)brandArray{
    if (!_brandArray) {
        self.brandArray = [NSMutableArray array];
    }
    return _brandArray;
}

- (NSMutableArray *)totalArray{
    if (!_totalArray) {
        self.totalArray = [NSMutableArray array];
    }
    return _totalArray;
}

- (NSMutableDictionary *)totalDic{
    if (!_totalDic) {
        self.totalDic = [NSMutableDictionary dictionary];
    }
    return _totalDic;
}

- (NSMutableArray *)totalKeyArray{
    if (!_totalKeyArray) {
        self.totalKeyArray = [NSMutableArray array];
    }
    return _totalKeyArray;
}

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
    
    // 创建右侧列表
    self.brandTableView = [[BrandTableView alloc]initWithFrame:CGRectMake(0, 0, self.rightView.bounds.size.width, self.rightView.bounds.size.height - 64) style:UITableViewStyleGrouped];
    [self.rightView addSubview:_brandTableView];
    
    self.urlDic = @{@"手机":@"20937", @"相机":@"20928", @"笔记本":@"20807", @"摄像机":@"20912", @"平板电脑":@"79849", @"超极本":@"95585"};
    __weak ProductViewController *vc = self; // 弱指向
    _brandTableView.IDBlock = ^void(NSString *IDBlock){
        vc.ID = IDBlock;
    };
    
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
#pragma 点击cell的时候进行对应的网络请求
    
    // 找到所点击的cell
    ProductListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *url = [NSString stringWithFormat:@"http://mrobot.pconline.com.cn/v3/product/brand/%@",_urlDic[cell.nameLable.text]];
    
        [NetHandler getDataWithUrl:url completion:^(NSData *data) {
            if (data != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
                if (dic) {
                    NSArray *brandArr = dic[@"partition"][@"recommondBrands"][@"brands"];
                    NSArray  *totalArr = dic[@"partition"][@"totalBrands"][@"sections"];
                    _brandArray = nil;
                    _totalDic = nil;
                    for (NSDictionary *dict in brandArr) {
                        BrandM *brandM = [[BrandM alloc]init];
                        [brandM setValuesForKeysWithDictionary:dict];
                        [self.brandArray addObject:brandM];
                    }
                    for (NSDictionary *dict in totalArr) {
                        NSArray *array = dict[@"brands"];
                        NSMutableArray *modelArray = [NSMutableArray array];
                        // 转换成Model类
                        for (NSDictionary *diction in array) {
                            TotalM *totalM = [[TotalM alloc]init];
                            [totalM setValuesForKeysWithDictionary:diction];
                            [modelArray addObject:totalM];
                        }
                        // 将存放Model类的数组按对应的key值存入字典
                        [self.totalDic setValue:modelArray forKey:dict[@"index"]];
                    }
                    _brandTableView.brandArray = _brandArray;
                    _brandTableView.totalDic = _totalDic;
                    [_brandTableView reloadData];
                }
                
            }
        }];
}

#pragma 观察者
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"center"]){
        CGFloat centerX = self.rightView.center.x;
        NSArray *cellArray = [_tableView visibleCells];
        [UIView animateWithDuration:0.5 delay:0 options:2 animations:^{
            for (int i = 0; i < cellArray.count; i++) {
                [cellArray[i] brandLable].alpha = 0.8 * ((centerX - sWIDTH * 5 / 8) /( 3 * sWIDTH / 4));
                NSLog(@"alpha = %f", [cellArray[i] brandLable].alpha);
                NSLog(@"center = %ld", (long)centerX);
            }
        } completion:nil];
        
    }else{
        if ([keyPath isEqualToString:@"identifier"]) {
            ProductListViewController *PLVC = [[ProductListViewController alloc]init];
            PLVC.urlID = self.ID;
            [self.navigationController pushViewController:PLVC animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
#pragma 添加观察者，观察rightView center的变化
    [self.rightView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
    [self.brandTableView addObserver:self forKeyPath:@"identifier" options:NSKeyValueObservingOptionNew context:nil];
}

// 移除观察者
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.rightView removeObserver:self forKeyPath:@"center" context:nil];
    [self.brandTableView removeObserver:self forKeyPath:@"identifier" context:nil];

}



@end
