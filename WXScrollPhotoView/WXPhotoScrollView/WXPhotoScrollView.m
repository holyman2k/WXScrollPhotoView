//
//  WXPhotoScrollView.m
//  WXScrollPhotoView
//
//  Created by Charlie Wu on 20/02/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXPhotoScrollView.h"

@interface WXPhotoScrollView() <UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation WXPhotoScrollView

- (id)initWithPageIndex:(NSUInteger)pageIndex;
{
    if (self = [super init]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _pageIndex = pageIndex;
        CGRect frame = [UIScreen mainScreen].bounds;
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        self.imageView.backgroundColor = [UIColor colorWithRed:1.000 green:0.985 blue:0.570 alpha:1.000];
        [self addSubview:self.imageView];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = YES;
        self.delegate = self;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect bound = self.bounds;
    CGRect imageFrame = self.imageView.frame;

    self.imageView.frame = self.bounds;

    // center horizontally
    if (imageFrame.size.width < bound.size.width) {
        imageFrame.origin.x = (bound.size.width - imageFrame.size.width) / 2;
    } else {
        imageFrame.origin.x = 0;
    }

    // center vertically
    if (imageFrame.size.height < bound.size.height) {
        imageFrame.origin.y = (bound.size.height - imageFrame.size.height) / 2;
    } else {
        imageFrame.origin.y = 0;
    }

    self.imageView.frame = imageFrame;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


- (void)setImage:(UIImage *)image
{
    self.imageView.frame = self.bounds;
    self.imageView.image = image;
    self.maximumZoomScale = 3;
    self.minimumZoomScale = 1;
}

- (void)prepairToReuse
{
    self.imageView.image = nil;
    self.zoomScale = 1;
}

- (void)reusePhotoScrollViewAtPageIndex:(NSUInteger)pageIndex
{
    _pageIndex = pageIndex;
}

@end
