//
//  BannerView.m
//  ScrollViewDemo
//
//  Created by Yolanda on 2017/5/16.
//  Copyright © 2017年 Yolanda. All rights reserved.
//

#import "BannerView.h"
@interface BannerView ()<UIScrollViewDelegate>

@property (nonatomic,assign) CGFloat eachDuration;
#pragma mark ---是否有计时器自动滚动
@property (nonatomic,assign) BOOL autoPlay;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray<UIImageView *> *imageViews;
@end
@implementation BannerView

-(instancetype)initWithFrame:(CGRect)frame
                    autoPlay:(BOOL)automatic
                    duration:(CGFloat)seconds
{
    if (self = [super initWithFrame:frame]) {
        self.autoPlay = automatic;
        _eachDuration = seconds;
    }
    return self;
}

- (void)autoPlayImageView:(NSTimer *)timer
{
    _currentIndex = (_currentIndex+1)%(_images.count);
    [self refreshContent];
}


-(void)setImages:(NSArray<UIImage *> *)images
{
    if (images) {
        _images = images;
    }
    
    [self customScrollView];
    _currentIndex = 0;
    if (_autoPlay && _images.count != 1) {
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:_eachDuration target:self selector:@selector(autoPlayImageView:) userInfo:nil repeats:YES];
        }
    }
    [self refreshContent];
}

#pragma mark --- 初始化滚动视图
- (void)customScrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.contentSize = CGSizeMake(3*_scrollView.bounds.size.width, _scrollView.bounds.size.height);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        [self customImageContentView];
    }
}


- (void)customImageContentView
{
    
    switch (_images.count) {
        case 0:
            return;
            break;
        case 1:
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.tag = 1001;
            [_scrollView addSubview:imageView];
            [self.imageViews addObject:imageView];
        }
            break;
        default:
        {
            for (int i = 0; i < 3; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView.bounds.size.width *i, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
                imageView.userInteractionEnabled = YES;
                imageView.tag = 1001+i;
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
                [imageView addGestureRecognizer:tap];
                [_scrollView addSubview:imageView];
                [self.imageViews addObject:imageView];
            }
        }
            break;
    }
    
}

- (void)refreshContent
{
    UIImageView *leftImageView = _imageViews[0];
    leftImageView.image = (UIImage *)(_images[(_currentIndex -1 + _images.count)%_images.count]);
    
    
    UIImageView *middleImageView = _imageViews[1];
    middleImageView.image = (UIImage *)_images[_currentIndex];
    ;
    
    UIImageView *rightImageView = _imageViews[2];
    rightImageView.image = (UIImage *)(_images[(_currentIndex + 1)%_images.count]);
    
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
    if (_scrollToIndex) {
        _scrollToIndex(_currentIndex);
    }
    
}
#pragma mark --- 点击某张图片

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    if (_tapImage) {
        _tapImage(_currentIndex);
    }
}

-(NSMutableArray<UIImageView *> *)imageViews
{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

#pragma mark --- UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat x = scrollView.contentOffset.x / _scrollView.bounds.size.width;
    if (x >1) {
        //左滑
        _currentIndex = (_currentIndex + 1)%_images.count;
    }else{
        //右滑
        _currentIndex =(_currentIndex - 1 + _images.count)%_images.count;
    }
    
    [self refreshContent];
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_eachDuration target:self selector:@selector(autoPlayImageView:) userInfo:nil repeats:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}


#pragma mark --- 示例代码

//BannerView  *bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 20,[UIScreen mainScreen].bounds.size.width, 200) autoPlay:YES duration:3];
//bannerView.tapImage = ^(NSInteger index) {
//    NSLog(@"%ld",index);
//};
//
//bannerView.scrollToIndex = ^(NSInteger index) {
//    _pageControl.currentPage = index;
//};


@end

