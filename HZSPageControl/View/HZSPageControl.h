//
//  HZSPageControl.h
//  PageControl
//
//  Created by Acan on 2019/4/24.
//  Copyright © 2019 weiphone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZSPageControl : UIView
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL hidesForSinglePage;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@end

NS_ASSUME_NONNULL_END
