//
//  NXBannerView.h
//  NXBannerView
//
//  Created by ChrisK on 4/13/15.
//  Copyright (c) 2015 niexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NXBannerViewDelegate <NSObject>
@optional
/** 
 *  点击了第 index 个imageView
 */
- (void)didTapImageViewAtIndex:(NSInteger)index;
@end

@interface NXBannerView : UIView<UIScrollViewDelegate>

/**
 *  图片翻页的时间间隔
 *  默认是3秒
 */
@property (nonatomic, assign) float eachDuration;

@property (nonatomic, weak) __nullable id <NXBannerViewDelegate> delegate;


/**

 @param frame 该view的frame
 @param imageURLArray 图片imageUrl的数组
 @return 返回该view
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame imageURLArray:(nonnull NSArray<NSString *> *)imageURLArray;

/** 
 示例代码：
 
 NXBannerView *bannerView = [[NXBannerView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100) imageURLArray:urlArray];
 bannerView.eachDuration = 7.0f;
 bannerView.delegate = self;
 [self.view addSubview:bannerView];
 
 */


@end
