//
//  BrandTableView.h
//  Jiexun
//
//  Created by skma on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IDBlock) (NSString *ID);

@interface BrandTableView : UITableView

/**
 *
 **/
@property (nonatomic, strong) NSMutableArray *brandArray;
@property (nonatomic, strong) NSArray *totalKeyArray;
@property (nonatomic, strong) NSMutableDictionary *totalDic;

@property (nonatomic, copy) IDBlock IDBlock;

@property (nonatomic, copy) NSString *identifier;


@end
