//
//  CellModel.h
//  Jiexun
//
//  Created by qiqi on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property (nonatomic, strong)NSString *image;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, assign)NSInteger cmtCount;
@property (nonatomic, strong)NSString *pubDate;
@property (nonatomic, strong)NSString *url;

@end
