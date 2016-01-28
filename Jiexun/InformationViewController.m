//
//  InformationViewController.m
//  Jiexun
//
//  Created by skma on 16/1/26.
//  Copyright © 2016年 jiexun. All rights reserved.
//

#import "InformationViewController.h"
#import "ItemScrollView.h"
#import "ImageViewDisplayView.h"
#import "NetHandler.h"
#import "photoScrollModel.h"
#import "HeadlineViewCell.h"
#import "CellModel.h"
#import "HeadlineDetailViewController.h"
@interface InformationViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *modelArray;
@property (nonatomic, strong)NSMutableArray *cellModelArray;
@property (nonatomic, strong)ImageViewDisplayView *displayView;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation InformationViewController

- (void)viewDidLoad {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建滚动条标题
    ItemScrollView *scrollView = [[ItemScrollView alloc] initWithFrame:CGRectMake(0, 0, sWIDTH, 60)];
     scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tianlan"]];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(9 * 60, 0);
    [self.view addSubview:scrollView];
    [self requireHeadlineData];
    
    [self addImageViewDisplayView];
    [self addTableView];
    
    
}
// 创建滚动视图
- (void)addImageViewDisplayView {
    self.displayView = [ImageViewDisplayView ImageViewDisplayViewWithFrame:CGRectMake(0, 60, sWIDTH, 200)];
       [self.view addSubview:_displayView];
    __weak InformationViewController *Test = self;
    [_displayView addTapEventForImageWithBlock:^(NSInteger imageIndex) {
        
            HeadlineDetailViewController *detailVC = [[HeadlineDetailViewController alloc] init];
            photoScrollModel *photoModel = Test.modelArray[imageIndex];
        detailVC.string = photoModel.url;
            [Test.navigationController pushViewController:detailVC animated:YES];
        
    }];

}
// 创建tableView
- (void)addTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 260, sWIDTH, sHEIGHT - 300) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    [self.view addSubview:self.tableView];
}
// 返回分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArray.count;
}

// 配置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadlineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[HeadlineViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    CellModel *cellModel = self.cellModelArray[indexPath.row];
    
    [cell configureCellWithModel:cellModel];
    return cell;
}
// 选中cell进入详情页面

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadlineDetailViewController *detailVC = [[HeadlineDetailViewController alloc] init];
    CellModel *cellModel = self.cellModelArray[indexPath.row];
    detailVC.string = cellModel.url;
    [self.navigationController pushViewController:detailVC animated:YES];
}

// 获取头条数据
- (void)requireHeadlineData{
    [NetHandler getDataWithUrl:@"http://mrobot.pconline.com.cn/v2/cms/channels/1?pageNo=1&pageSize=20&appVersion=4.3.0" completion:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSArray *arr = dict[@"focus"];
        self.modelArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in arr) {
            photoScrollModel *photoModel = [[photoScrollModel alloc] init];
            [photoModel setValuesForKeysWithDictionary:dic];
            [self.modelArray addObject:photoModel];
         }
            NSArray *array = dict[@"articleList"];
        self.cellModelArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            CellModel *cellModel = [[CellModel alloc] init];
            [cellModel setValuesForKeysWithDictionary:dic];
            [self.cellModelArray addObject:cellModel];
        }
        _displayView.modelArray = self.modelArray;
        [self.tableView reloadData];
     }];
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
