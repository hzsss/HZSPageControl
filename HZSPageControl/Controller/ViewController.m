//
//  ViewController.m
//  HZSPageControl
//
//  Created by Acan on 2019/4/25.
//  Copyright © 2019 hzs. All rights reserved.
//

#import "ViewController.h"
#import "HZSPageControl.h"
#import "HZSCollectionViewCell.h"

static const NSInteger pageCount = 5;
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HZSPageControl *pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    self.collectionView.frame = CGRectMake((width - 320) * 0.5, (height - 180) * 0.5, 320, 180);
    
    self.pageControl.frame = CGRectMake((width - 80) * 0.5, CGRectGetMaxY(self.collectionView.frame) - 16, 80, 10);
}

- (void)setupSubViews {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = CGSizeMake(320, 180);
    self.layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [self.collectionView registerClass:[HZSCollectionViewCell class] forCellWithReuseIdentifier:@"reuseIdentifier"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.pageControl = [[HZSPageControl alloc] init];
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.dotMaxWidth = 20;
    self.pageControl.dotMinWidth = 10;
    [self.view addSubview:self.pageControl];
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return pageCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HZSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    [cell setupWithBackgroundImage:[UIImage imageNamed:@"image"]];
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.pageControl.currentPage = indexPath.row;
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.layout.itemSize.width;

    self.pageControl.currentPage = index;
}

@end
