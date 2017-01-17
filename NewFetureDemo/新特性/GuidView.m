//
//  GuidView.m
//  新特性Demo
//
//  Created by 陈伟鑫 on 2017/1/16.
//  Copyright © 2017年 陈伟鑫. All rights reserved.
//

#import "GuidView.h"


@interface GuidView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation GuidView

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3", nil];
    }
    return _imageArray;
}

- (UIPageControl *)pageControl {
    if (!_pageControl ) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 100, self.bounds.size.width, 20)];
        _pageControl.numberOfPages = self.imageArray.count + 1;
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = self.pageColor;
        _pageControl.currentPageIndicatorTintColor = self.currenPageColor ? self.currenPageColor :[UIColor purpleColor];
        
    }
    return _pageControl;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * (self.imageArray.count + 1), 0);
    }
    return _scrollView;
}
- (void)show {
//    GuidView *guidView = [[GuidView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    for (int i = 0; i < self.imageArray.count; i ++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.imageArray[i] ofType:@"png"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.bounds.size.width, 0 , self.bounds.size.width, self.bounds.size.height)];
        imageView.image = [UIImage imageWithContentsOfFile:path];
        [self.scrollView addSubview:imageView];
    }
    
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / self.bounds.size.width;
    
    if (scrollView.contentOffset.x == (self.imageArray.count) * self.bounds.size.width) {
        [self removeFromSuperview];
    }
}
@end
