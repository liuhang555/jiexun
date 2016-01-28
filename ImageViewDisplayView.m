
//
//  ImageViewDisplayView.m
//  11111
//
//  Created by qiqi on 16/1/24.
//  Copyright © 2016年 qiqi. All rights reserved.
//

#import "ImageViewDisplayView.h"

#import "UIImageView+WebCache.h"
@interface ImageViewDisplayView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *imagePageControl;
@property (nonatomic, assign) CGFloat widthOfView;
@property (nonatomic, assign) CGFloat heightOfView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TapImageViewBolck block;
@end

@implementation ImageViewDisplayView
#pragma -- 遍历构造器
+ (instancetype) ImageViewDisplayViewWithFrame: (CGRect) frame {
    ImageViewDisplayView *instance = [[ImageViewDisplayView alloc] initWithFrame:frame];
    return instance;
}


#pragma -- mark 遍历初始化方法
- (instancetype)initWithFrame: (CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _widthOfView = frame.size.width;            //获取滚动视图的宽度
        _heightOfView = frame.size.height;            //获取滚动视图的高度
        
        
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _widthOfView, _heightOfView)];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        [self addSubview:_mainScrollView];

        self.clipsToBounds = YES;
       
    }
    return self;
}
- (void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    [self addImageviewsForMainScroll];    //添加ImageView
   
    //设置ContentSize
    _mainScrollView.contentSize = CGSizeMake(_widthOfView * _modelArray.count, 0);
    
    [self addPageControl];
    [self addTimerLoop];            //添加timer
}

- (void)addTapEventForImageWithBlock: (TapImageViewBolck)block{
    if (_block == nil) {
        if (block != nil) {
            _block = block;
        }
    }
}
/**
 *  添加PageControl
 */
- (void) addPageControl{
    _imagePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_widthOfView / 3, _heightOfView - 20, _widthOfView, 20)];
    _imagePageControl.numberOfPages = _modelArray.count;
    _imagePageControl.currentPage = 0;
    _imagePageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _imagePageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
     self.imagePageControl.numberOfPages = _modelArray.count;
    [_imagePageControl addTarget:self action:@selector(changePage:) forControlEvents:(UIControlEventValueChanged)];
    [self addSubview:_imagePageControl];
}


/**
 *  给ScrollView添加ImageView
 */
-(void) addImageviewsForMainScroll{
    if (_modelArray != nil) {
        for ( int i = 0; i < _modelArray.count; i ++) {
            self.photoModel = _modelArray[i];

            UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_widthOfView * i, 0, _widthOfView, _heightOfView)];
            tempImageView.userInteractionEnabled = YES;
            tempImageView.clipsToBounds = YES;
           [tempImageView sd_setImageWithURL:[NSURL URLWithString:self.photoModel.image]placeholderImage:nil];
            
            
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(_widthOfView * i, 0, _widthOfView, 20)];
            tempLabel.text = self.photoModel.title;
            tempLabel.font = F15;
            tempLabel.textColor = [UIColor whiteColor];
            
            UIButton *tempButton = [[UIButton alloc] initWithFrame: CGRectMake(_widthOfView * i, 0, _widthOfView, _heightOfView)];
            [tempButton addTarget:self action:@selector(tapImageButton:) forControlEvents:UIControlEventTouchUpInside];
            tempButton.tag = i;
           
            [_mainScrollView addSubview:tempImageView];
            [_mainScrollView addSubview:tempLabel];
            [_mainScrollView addSubview:tempButton];

        }
      
    }
}

- (void) tapImageButton: (UIButton *) sender{
    if (_block) {
        _block(sender.tag);
    }
}


- (void) addTimerLoop{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];
}

- (void)changeOffset{
    CGFloat x = _mainScrollView.contentOffset.x;
    if (x >= (_modelArray.count - 1) * _widthOfView) {
        _mainScrollView.contentOffset = CGPointMake(0, 0);
        _imagePageControl.currentPage = 0;
        
    }else{
        _mainScrollView.contentOffset = CGPointMake(x + _widthOfView, 0);
        _imagePageControl.currentPage ++;
    }
}

-(void)changePage:(UIPageControl *)pageControl{
    _mainScrollView.contentOffset = CGPointMake(_imagePageControl.currentPage * _widthOfView, 0);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_timer invalidate];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _imagePageControl.currentPage = scrollView.contentOffset.x / _widthOfView;
    [self addTimerLoop];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
