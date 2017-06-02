//
//  BannerView.h
//  ScrollViewDemo
//
//  Created by Yolanda on 2017/5/16.
//  Copyright © 2017年 Yolanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView

-(instancetype)initWithFrame:(CGRect)frame
                    autoPlay:(BOOL)automatic
                    duration:(CGFloat)seconds;

@property (nonatomic,strong) NSArray<UIImage *> *images;
#pragma mark ---点击了哪张图片
@property (nonatomic,strong) void(^tapImage)(NSInteger index);
#pragma mark ---滚动到哪张图片 （按索引值从0开始）
@property (nonatomic,strong) void(^scrollToIndex)(NSInteger index);


@end
