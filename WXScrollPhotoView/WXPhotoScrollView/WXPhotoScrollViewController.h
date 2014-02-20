//
//  WXPhotoScrollViewController.h
//  WXScrollPhotoView
//
//  Created by Charlie Wu on 20/02/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXPhotoScrollView.h"


@class WXPhotoScrollViewController;

@protocol WXPhotoScrollViewControllerDataSource <NSObject>

- (NSUInteger)numberOfPhotos;

- (void)photoScrollView:(WXPhotoScrollView *)photoScrollView photoAtPageIndex:(NSUInteger)pageIndex isLoading:(BOOL *)isLoading;

@end

@interface WXPhotoScrollViewController : UIViewController
@property (weak, nonatomic) id<WXPhotoScrollViewControllerDataSource> datasource;
@end
