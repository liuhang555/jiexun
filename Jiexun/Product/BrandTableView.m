//
//  BrandTableView.m
//  Jiexun
//
//  Created by skma on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "BrandTableView.h"
#import "BrandTableViewCell.h"

#import "BrandM.h"
#import "TotalM.h"

@interface BrandTableView()<UITableViewDataSource, UITableViewDelegate>



@end


@implementation BrandTableView



- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (style) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back"]];
        self.dataSource = self;
        self.delegate = self;
//        self.rowHeight = sHEIGHT / 8;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _totalKeyArray.count + 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return _brandArray.count;
    }else{
        if (_totalDic != nil) {
            NSArray *arr = _totalDic[_totalKeyArray[section - 3]];
            return arr.count;
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reused = @"reuse";
    static NSString *reused1 = @"reuse1";
    if (indexPath.section < 3) {
        BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reused];
        if (!cell) {
            cell = [[BrandTableViewCell alloc]init];
        }
        if (indexPath.section == 0) {
            [cell getUrl:nil name:@"排行榜"];
        }else if (indexPath.section == 1) {
            [cell getUrl:nil name:@"全部品牌"];
        }else if (indexPath.section == 2) {
            BrandM *brandM = _brandArray[indexPath.row];
            [cell getUrl:brandM.logo name:brandM.name];
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reused1];
        if (!cell) {
            cell = [[UITableViewCell alloc]init];
        }
        if (_totalDic != nil) {
            NSArray *arr = _totalDic[_totalKeyArray[indexPath.section - 3]];
            TotalM *totalM = arr[indexPath.row];
            cell.textLabel.text = totalM.name;
        }
        return cell;
    }
    
}

// 索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *array = [NSMutableArray arrayWithArray:_totalKeyArray];
    
    [array insertObject:@"" atIndex:0];
    [array insertObject:@"荐" atIndex:0];
    [array insertObject:@"推" atIndex:0];
//    [NSMutableArray arrayWithObjects:@"排行榜", @"全部品牌", @"推荐品牌", nil];
   
    return array;
}

// 分区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"排行榜";
    }else if(section == 1){
        return @"全部品牌";
    }else if(section == 2){
        return @"热门推荐";
    }else{
        return _totalKeyArray[section - 3];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section < 3) {
        return sHEIGHT / 8;
    }else{
        return 60;
    }
}

// 重写setter方法
- (void)setTotalDic:(NSMutableDictionary *)totalDic{
    _totalDic = totalDic;
    if (_totalDic != nil) {
        self.totalKeyArray =[[_totalDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
        NSLog(@"ar = %@", _totalKeyArray);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BrandTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
        
    }else if (indexPath.section == 2) {
        if (self.IDBlock) {
            
            BrandM *brandM = _brandArray[indexPath.row];
            self.IDBlock(brandM.ID);
            self.identifier = nil;
        }
    }else{
        
        NSArray *arr = _totalDic[_totalKeyArray[indexPath.section - 3]];
        
        TotalM *totalM = arr[indexPath.row];
        self.IDBlock(totalM.ID);// 先调用block再改变观察属性的值
        self.identifier = nil;
        
    }
}



@end
