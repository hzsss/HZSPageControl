//
//  HZSPageControl.m
//  PageControl
//
//  Created by Acan on 2019/4/24.
//  Copyright © 2019 weiphone. All rights reserved.
//

#import "HZSPageControl.h"

@interface HZSPageDot : UIView
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@end

@implementation HZSPageDot

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    self.backgroundColor = selected ? self.currentPageIndicatorTintColor : self.pageIndicatorTintColor;
    _selected = selected;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = self.bounds.size.height;
    self.layer.cornerRadius = height * 0.5;
}

@end

@interface HZSPageControl()
@property (nonatomic, strong) NSMutableArray *dots;
@property (nonatomic, strong) HZSPageDot *preDot;
@end

@implementation HZSPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dots = [NSMutableArray array];
        
        // 提供默认值
        self.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        self.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.dotMaxWidth = 16;
        self.dotMinWidth = 6;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat gap = (width - self.dotMinWidth * (self.numberOfPages - 1) - self.dotMaxWidth) / (self.numberOfPages - 1);
    
    for (NSInteger i=0; i<self.numberOfPages; i++) {
        HZSPageDot *dot = (HZSPageDot *)self.dots[i];
        CGFloat dotWidth = dot.selected ? self.dotMaxWidth : self.dotMinWidth;
        
        HZSPageDot *tmpDot = nil;
        CGFloat x = 0;
        if (i != 0) {
            tmpDot = (HZSPageDot *)self.dots[i - 1];
            x = CGRectGetMaxX(tmpDot.frame) + gap;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            dot.frame = CGRectMake(x, 0, dotWidth, self.dotMinWidth);
        }];
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    self.hidden = self.hidesForSinglePage && numberOfPages == 1;
    
    for (NSInteger i=0; i<numberOfPages; i++) {
        HZSPageDot *dot = [[HZSPageDot alloc] init];
        dot.pageIndicatorTintColor = self.pageIndicatorTintColor;
        dot.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
        dot.selected = i == 0 ? YES : NO;
        [self.dots addObject:dot];
        [self addSubview:dot];
    }
    if (numberOfPages > 0) self.preDot = self.dots[0];
    [self layoutIfNeeded];
    _numberOfPages = numberOfPages;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    self.preDot.selected = NO;
    HZSPageDot *dot = self.dots[currentPage];
    self.preDot = dot;
    dot.selected = YES;
    [self setNeedsLayout];
    _currentPage = currentPage;
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    self.hidden = hidesForSinglePage && self.numberOfPages == 1;
    
    _hidesForSinglePage = hidesForSinglePage;
}

@end
