//
//  NXBannerView.m
//  LoveFit
//
//  Created by niexin on 4/13/15.
//  Copyright (c) 2015 niexin. All rights reserved.
//

#import "NXBannerView.h"
@interface NXBannerView()
@property (nonatomic,strong) NSMutableArray *imageViewArray;
@property (nonatomic,strong) NSTimer        *currentTimer;
@property (nonatomic,assign) float          nowOffsetx;
@property (nonatomic,assign) BOOL firstTime;
@end

@implementation NXBannerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _imageViewArray = [NSMutableArray array];
        _firstTime = YES;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageViewArray = [NSMutableArray array];
    }
    return self;
}

-(void)setImageCount:(NSInteger)imageCount
{
    _imageCount = imageCount;
    if (_imageCount == 0) {
        return;
    }
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * (_imageCount+2), self.scrollView.frame.size.height);
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    for (int i = 0; i<_imageCount+2; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        imageV.userInteractionEnabled = YES;
        imageV.tag = 1000+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [imageV addGestureRecognizer:tap];
        [_scrollView addSubview:imageV];
        [_imageViewArray addObject:imageV];
    }
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    _nowOffsetx = self.frame.size.width;
    
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
    _currentTimer = [NSTimer scheduledTimerWithTimeInterval:_eachDuration target:self selector:@selector(doTheSwitchAnimation) userInfo:nil repeats:YES];
    [_currentTimer fire];
}

- (void)doTheSwitchAnimation
{
    if (_firstTime) {
        _firstTime = NO;
        return;
    }
    [_scrollView setContentOffset:CGPointMake(_nowOffsetx + self.frame.size.width, 0) animated:YES];
}


- (void)beginSetImages
{
    if (self.delegate && _imageCount && [self.delegate respondsToSelector:@selector(setImageView:withIndex:)]) {
        for (int i = 0; i<_imageCount+2; i++) {
            NSInteger index = 0;
            if (i == 0) {
                index = _imageCount-1;
            }else if (i == _imageCount+1){
                index = 0;
            }else{
                index = i-1;
            }
            [self.delegate setImageView:[_imageViewArray objectAtIndex:i] withIndex:index];
        }
    }
}



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
    _currentTimer = [NSTimer scheduledTimerWithTimeInterval:_eachDuration target:self selector:@selector(doTheSwitchAnimation) userInfo:nil repeats:YES];
    _firstTime = YES;
    [_currentTimer fire];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
