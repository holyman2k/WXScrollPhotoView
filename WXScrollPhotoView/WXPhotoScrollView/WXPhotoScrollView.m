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
        _pageIndex = pageIndex;
        CGRect frame = [UIScreen mainScreen].bounds;
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imageView];
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
    self.imageView.image = image;
    self.maximumZoomScale = 2;
    self.minimumZoomScale = 1;
}

- (void)prepairToReuse
{
    self.imageView.image = nil;
    self.imageView.frame = self.bounds;
}

- (void)reusePhotoScrollViewAtPageIndex:(NSUInteger)pageIndex
{
    _pageIndex = pageIndex;
}

@end
