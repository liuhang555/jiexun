
//
//  AppleViewController.m
//  Jiexun
//
//  Created by qiqi on 16/1/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AppleViewController.h"
#import "HeadlineViewCell.h"
#import "CellModel.h"
#import "NetHandler.h"
#import "HeadlineDetailViewController.h"
@interface AppleViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *AppleArray;
@end

@implementation AppleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, sWIDTH, sHEIGHT - 60) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    [self.view addSubview:self.tableView];
    
}

// 返回分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.AppleArray.count;
}

// 配置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadlineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[HeadlineViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    CellModel *cellModel = self.AppleArray[indexPath.row];
    
    [cell configureCellWithModel:cellModel];
    return cell;
}

// 选中cell进入详情页面

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadlineDetailViewController *detailVC = [[HeadlineDetailViewController alloc] init];
    CellModel *cellModel = self.AppleArray[indexPath.row];
    detailVC.string = cellModel.url;
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)requireAppleData {
    [NetHandler getDataWithUrl:@"http://mrobot.pconline.com.cn/v2/cms/channels/5?appVersion=4.3.0&pageSize=20&pageNo=1" completion:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSArray *array = dict[@"articleList"];
        self.AppleArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            CellModel *cellModel = [[CellModel alloc] init];
            [cellModel setValuesForKeysWithDictionary:dic];
            [self.AppleArray addObject:cellModel];
        }
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
