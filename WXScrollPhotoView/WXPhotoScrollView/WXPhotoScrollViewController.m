//
//  WXPhotoScrollViewController.m
//  WXScrollPhotoView
//
//  Created by Charlie Wu on 20/02/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXPhotoScrollViewController.h"

@interface WXPhotoScrollViewController() <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *pagingScrollView;
@property (strong, nonatomic) NSMutableSet *recycledPages;
@property (strong, nonatomic) NSMutableSet *visiblePages;
@end

@implementation WXPhotoScrollViewController

- (void)loadView
{
//    [super loadView];

    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.x = -10;
    frame.size.width += 20;
    self.pagingScrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.pagingScrollView.contentSize = CGSizeMake(frame.size.width * self.datasource.numberOfPhotos,
                                             frame.size.height);

    self.pagingScrollView.delegate = self;
    self.pagingScrollView.backgroundColor = [UIColor colorWithRed:0.337 green:0.608 blue:0.792 alpha:1.000];
    self.pagingScrollView.pagingEnabled = YES;
    self.pagingScrollView.bouncesZoom = YES;
    self.pagingScrollView.bounces = YES;
    self.pagingScrollView.showsHorizontalScrollIndicator = YES;
    self.pagingScrollView.showsVerticalScrollIndicator = YES;

    self.view = self.pagingScrollView;
    self.recycledPages = [[NSMutableSet alloc] init];
    self.visiblePages = [[NSMutableSet alloc] initWithCapacity:3];
    [self tilePages];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self tilePages];
}

- (void)viewDidAppear:(BOOL)animated
{
    CGRect pageingScrollViewFrame = [UIScreen mainScreen].bounds;
    pageingScrollViewFrame.origin.x = -10;
    pageingScrollViewFrame.size.width += 20;
    self.pagingScrollView.frame = pageingScrollViewFrame;
}

- (void)tilePages
{
    CGRect visibleBound = self.pagingScrollView.bounds;

    NSInteger firstNeededPageIndex = floorf(CGRectGetMinX(visibleBound) / CGRectGetWidth(visibleBound));
    NSInteger lastNeededPageIndex = floorf((CGRectGetMaxX(visibleBound) - 1) / CGRectGetWidth(visibleBound));

    firstNeededPageIndex = MAX(firstNeededPageIndex, 0);
    lastNeededPageIndex = MIN(lastNeededPageIndex, self.datasource.numberOfPhotos - 1);

    // recycle pages
    for (WXPhotoScrollView *photoScrollView in self.visiblePages) {
        if (photoScrollView.pageIndex < firstNeededPageIndex || photoScrollView.pageIndex > lastNeededPageIndex) {
            [photoScrollView removeFromSuperview];
            [self.recycledPages addObject:photoScrollView];
            [photoScrollView prepairToReuse];
        }
    }
    [self.visiblePages minusSet:self.recycledPages];

    // add visible pages

    for (NSUInteger i = firstNeededPageIndex; i <= lastNeededPageIndex; i++) {
        if (![self isDisplayingPhotoScrollViewForPageIndex:i]) {
            WXPhotoScrollView *photoScrollView = [self dequeueRecycledPages];
            if (!photoScrollView) {
                photoScrollView = [[WXPhotoScrollView alloc] initWithPageIndex:i];
            } else {
                [photoScrollView reusePhotoScrollViewAtPageIndex:i];
            }
            [self configPhotoScrollView:photoScrollView atPageIndex:i];
            [self.pagingScrollView addSubview:photoScrollView];
            [self.visiblePages addObject:photoScrollView];
        }
    }
}

- (BOOL)isDisplayingPhotoScrollViewForPageIndex:(NSUInteger)pageIndex
{
    for (WXPhotoScrollView *photoScrollView in self.visiblePages) {
        if (photoScrollView.pageIndex == pageIndex) {
            return YES;
        }
    }
    return NO;
}

- (void)configPhotoScrollView:(WXPhotoScrollView *)photoScrollView atPageIndex:(NSUInteger)pageIndex
{
    CGRect pageingScrollViewFrame = [UIScreen mainScreen].bounds;
    pageingScrollViewFrame.origin.x = -10;
    pageingScrollViewFrame.size.width += 20;
    self.pagingScrollView.frame = pageingScrollViewFrame;

    CGRect frame = [UIScreen mainScreen].bounds;

    frame.origin.x = (frame.size.width + 20) * pageIndex + 10;
    photoScrollView.frame = frame;
    photoScrollView.backgroundColor = [UIColor whiteColor];
    BOOL isLoading = NO;
    [self.datasource photoScrollView:photoScrollView photoAtPageIndex:pageIndex isLoading:&isLoading];
}

- (id)dequeueRecycledPages
{
    id page = self.recycledPages.anyObject;
    if (page) {
        [self.recycledPages removeObject:page];
    }
    return page;
}

@end
