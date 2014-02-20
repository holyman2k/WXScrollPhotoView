//
//  WXPhotoViewController.m
//  WXScrollPhotoView
//
//  Created by Charlie Wu on 20/02/2014.
//  Copyright (c) 2014 Charlie Wu. All rights reserved.
//

#import "WXPhotoViewController.h"

@interface WXPhotoViewController() <WXPhotoScrollViewControllerDataSource>

@end

@implementation WXPhotoViewController

- (void)awakeFromNib
{
    self.datasource = self;
}

- (NSUInteger)numberOfPhotos
{
    return 10;
}

- (void)photoScrollView:(WXPhotoScrollView *)photoScrollView photoAtPageIndex:(NSUInteger)pageIndex isLoading:(BOOL *)isLoading
{
    *isLoading = NO;
    UIImage *image = [self imageAtPageIndex:pageIndex];
    [photoScrollView setImage:image];
}

- (UIImage *)imageAtPageIndex:(NSUInteger)pageIndex
{
    NSString *text = [NSString stringWithFormat:@"Page: %d", pageIndex + 1];
    UIFont *font = [UIFont boldSystemFontOfSize: 40];
    NSDictionary *attributesDictionary = @{NSFontAttributeName: font};
    CGRect frame = [text boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                      options: NSStringDrawingUsesLineFragmentOrigin
                                   attributes:attributesDictionary
                                      context:nil];

    frame.origin.x = ([UIScreen mainScreen].bounds.size.width - frame.size.width) / 2;// - frame.size.width / 2;
    frame.origin.y = ([UIScreen mainScreen].bounds.size.height - frame.size.height) / 2;//- frame.size.height / 2;

    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.000 green:0.396 blue:0.317 alpha:1.000].CGColor);
    CGContextFillRect(context, [UIScreen mainScreen].bounds);

    [text drawWithRect:frame
                 options:NSStringDrawingUsesLineFragmentOrigin
              attributes:@{NSFontAttributeName: font}
                 context:[[NSStringDrawingContext alloc] init]];

    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();   // extract the image
    UIGraphicsEndImageContext();     // clean  up the context.
    return theImage;

}

@end
