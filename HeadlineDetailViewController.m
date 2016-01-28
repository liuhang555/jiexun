
//
//  HeadlineDetailViewController.m
//  Jiexun
//
//  Created by qiqi on 16/1/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "HeadlineDetailViewController.h"
#import "UMSocial.h"
@interface HeadlineDetailViewController () <UIWebViewDelegate, UITableViewDataSource, UITableViewDelegate, UMSocialUIDelegate>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation HeadlineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button1.frame = CGRectMake(20, 20, 30, 30);
    [button1 setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [button1 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button1 addTarget:self action:@selector(doBack:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button1];
    
    
    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button2.frame = CGRectMake(sWIDTH - 50, 20, 30, 30);
    [button2 setBackgroundImage:[UIImage imageNamed:@"fenxiang"] forState:(UIControlStateNormal)];
    [button2 setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [button2 addTarget:self action:@selector(doShare:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button2];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 60, sWIDTH, sHEIGHT - 60)];
    webView.delegate = self;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.string] cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:20];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(sWIDTH / 3 * 2, 60, sWIDTH / 3, 120) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    
}

- (void)doBack:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doShare:(UIButton *)button {
    [self.view addSubview:self.tableView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"5688b00167e58e5e6700367d"
//                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
//                                     shareImage:[UIImage imageNamed:@"4.jpg"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ, UMShareToQzone, UMShareToSina, UMShareToTencent, nil]
//                                       delegate:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    NSArray *arr1 = @[@"xinlang",@"weixin",@"qq"];
    NSArray *arr2 = @[@"分享到新浪",@"分享到微信",@"分享到QQ"];
    cell.imageView.image = [UIImage imageNamed:arr1[indexPath.row]];
    cell.textLabel.text = arr2[indexPath.row];
    cell.textLabel.font = F10;
    return cell;
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
