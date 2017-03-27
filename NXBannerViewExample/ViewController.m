//
//  ViewController.m
//  NXBannerViewExample
//
//  Created by Chris on 2017/3/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "ViewController.h"
#import "NXBannerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 500)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    [self.view addSubview:scrollView];
    
    NSArray *urlArray = @[
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490600802249&di=276fa4b4a67d8d6ecf0aae19e2068c60&imgtype=0&src=http%3A%2F%2Fp2.gexing.com%2Fshaitu%2F2012%2F7%2F20%2F201270820134320.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491195591&di=b1c58d0f52ab923a1b1129c17d6ae6ed&imgtype=jpg&er=1&src=http%3A%2F%2Fpic25.nipic.com%2F20121108%2F5955207_220357242000_2.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490600896245&di=b80b45506f08a881f1a326729b52a82c&imgtype=0&src=http%3A%2F%2Fpic36.photophoto.cn%2F20150714%2F0035035943244411_b.jpg",
                          @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490600922460&di=9676afb020fae5f096307c9b2ce9348a&imgtype=0&src=http%3A%2F%2Fpic61.nipic.com%2Ffile%2F20150303%2F18733170_110135178000_2.jpg"
                          ];
    
    NXBannerView *bannerView = [[NXBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) imageURLArray:urlArray];
    [scrollView addSubview:bannerView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
