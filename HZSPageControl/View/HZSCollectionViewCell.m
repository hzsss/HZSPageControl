//
//  HZSCollectionViewCell.m
//  HZSPageControl
//
//  Created by Acan on 2019/4/25.
//  Copyright © 2019 hzs. All rights reserved.
//

#import "HZSCollectionViewCell.h"

@interface HZSCollectionViewCell()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation HZSCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundImageView = [[UIImageView alloc] init];
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.backgroundImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundImageView.frame = self.bounds;
}

- (void)setupWithBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
    
    [self setNeedsLayout];
}

@end
