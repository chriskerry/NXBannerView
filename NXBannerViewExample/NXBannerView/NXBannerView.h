//
//  NXBannerView.h
//  LoveFit
//
//  Created by niexin on 4/13/15.
//  Copyright (c) 2015 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NXBannerViewDelegate <NSObject>
/**
 *  设置第xx个imageView的image
 */
- (void)setImageView:(UIImageView *)imageV withIndex:(NSInteger)index;

/** 
 *  点击了第xx个imageView
 */
- (void)didTapImageViewAtIndex:(NSInteger)index;
@end

@interface NXBannerView : UIView<UIScrollViewDelegate>

/** 
 *  图片的个数
 */
@property (nonatomic) NSInteger imageCount;

/**
 *  图片翻页的时间间隔
 */
@property (nonatomic) float eachDuration;

/**
 *  该view上面的scrollView
 */
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) id<NXBannerViewDelegate>delegate;

/**
 *准备好设置图片了就调用这个方法.
 *调用完，此view的delegate会调用 setImageView:(UIImageView *)imageV withIndex:(NSInteger)index 方法
 */
- (void)beginSetImages;

/** 
 示例代码：
 
 NXBannerView *bannerView = [[NXBannerView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100)];
 [bannerView setImageCount:3];
 bannerView.eachDuration = 7.0f;
 bannerView.delegate = self;
 [bannerView beginSetImages];
 [self.view addSubview:bannerView];
 
 */


@end
