//
//  NXBannerView.m
//  NXBannerView
//
//  Created by ChrisK on 4/13/15.
//  Copyright (c) 2015 niexin. All rights reserved.
//

#import "NXBannerView.h"
#import "UIImageView+WebCache.h"
@interface NXBannerView()
@property (nonatomic,strong) NSTimer *currentTimer;
/**
 *  现在scrollView的偏移量
 */
@property (nonatomic,assign) float nowOffsetx;

/**
 *  该view上面的scrollView
 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**
 *  图片的个数
 */
@property (nonatomic, assign) NSInteger imageCount;

/**
 *  图片URL数组
 */
@property (nonatomic, strong, nonnull) NSArray<NSString *> *imageURLArray;
@end

@implementation NXBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _eachDuration = 3.0f;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageURLArray:(nonnull NSArray<NSString *> *)imageURLArray
{
    if (self = [self initWithFrame:frame]) {
        
        _imageURLArray = imageURLArray;
        if (_imageURLArray.count == 0) {
            return self;
        }
        _imageCount = _imageURLArray.count;
        
        [self initImageViews];
        
        [self initTimer];
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * (_imageCount+2), self.scrollView.frame.size.height);
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)initImageViews
{
    for (int i = 0; i<_imageCount+2; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imageV.userInteractionEnabled = YES;
        imageV.tag = 1000+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [imageV addGestureRecognizer:tap];
        [self.scrollView addSubview:imageV];
        
        NSInteger index = 0;
        if (i == 0) {
            index = _imageCount-1;
        }else if (i == _imageCount+1){
            index = 0;
        }else{
            index = i-1;
        }
        [imageV sd_setImageWithURL:[NSURL URLWithString:[_imageURLArray objectAtIndex:index]]];
    }
    
    _nowOffsetx = self.frame.size.width;
}

- (void)initTimer
{
    _currentTimer = [NSTimer timerWithTimeInterval:_eachDuration target:self selector:@selector(doTheSwitchAnimation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_currentTimer forMode:NSRunLoopCommonModes];
}

- (void)tapImage:(UIGestureRecognizer *)tap
{
    if (tap.view.tag - 1000 == 0 || tap.view.tag - 1000 == _imageCount+1) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapImageViewAtIndex:)]) {
        [self.delegate didTapImageViewAtIndex:tap.view.tag - 1001];
    }
}

-(void)setEachDuration:(float)eachDuration
{
    _eachDuration = eachDuration;
    
    [self initTimer];
}

- (void)doTheSwitchAnimation
{
    [_scrollView setContentOffset:CGPointMake(_nowOffsetx + self.frame.size.width, 0) animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _nowOffsetx = scrollView.contentOffset.x;
    
    if (_nowOffsetx == self.frame.size.width *(_imageCount+1)) {
        _nowOffsetx = self.frame.size.width;
        [scrollView setContentOffset:CGPointMake(_nowOffsetx, 0) animated:NO];
    }
    if (_nowOffsetx == 0) {
        _nowOffsetx = _imageCount * self.frame.size.width;
        [scrollView setContentOffset:CGPointMake(_nowOffsetx, 0) animated:NO];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _nowOffsetx = scrollView.contentOffset.x;
    if (_nowOffsetx == self.frame.size.width *(_imageCount+1)) {
        _nowOffsetx = self.frame.size.width;
        [scrollView setContentOffset:CGPointMake(_nowOffsetx, 0) animated:NO];
    }
    if (_nowOffsetx == 0) {
        _nowOffsetx = _imageCount * self.frame.size.width;
        [scrollView setContentOffset:CGPointMake(_nowOffsetx, 0) animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_currentTimer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self initTimer];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
