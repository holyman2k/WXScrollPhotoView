//
//  WXPhotoScrollView.h
//  WXScrollPhotoView
//
//  Created by Charlie Wu on 20/02/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXPhotoScrollView : UIScrollView

@property (nonatomic, readonly) NSUInteger pageIndex;

- (id)initWithPageIndex:(NSUInteger)pageIndex;

- (void)setImage:(UIImage *)image;

- (void)prepairToReuse;

- (void)reusePhotoScrollViewAtPageIndex:(NSUInteger)pageIndex;

@end
