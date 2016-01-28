//
//  TotalM.m
//  Jiexun
//
//  Created by skma on 16/1/28.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TotalM.h"

@implementation TotalM

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

@end
