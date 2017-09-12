//
//  ViewController.m
//  面向协议编程
//
//  Created by 李洞洞 on 11/9/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionCell.h"
#import "UIView+XMGExtension.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static NSString * const cellID = @"cellID";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)CustomCollectionCell * cell;
@property(nonatomic,strong)NSIndexPath * indexPath;
@end

@implementation ViewController
- (UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout =
        [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH+20, SCREEN_HEIGHT);
        flowLayout.minimumLineSpacing = 0.0;
        flowLayout.minimumInteritemSpacing = 0.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH+20, SCREEN_HEIGHT)collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        }
    
    return _collectionView;
}

/**
 self.view的宽度是: SCREEN_WIDTH+20
 collectionView的宽度是: SCREEN_WIDTH+20
 collectionViewCell的宽度是:SCREEN_WIDTH+20
 collectionViewCell上显示内容的imageView的宽度是:SCREEN_WIDTH
 分页显示collectionView.pagingEnabled = YES分的页是SCREEN_WIDTH+20
 你看到的永远是屏幕宽 分页时分的却是SCREEN_WIDTH+20 造成滑动分页时 两个cell之间有间隙的假象
 */
- (void)loadView
{
    [super loadView];
    self.view.xmg_width += 20;
//    CGRect rect = self.view.frame;
//    rect.size.width += 20;
//    self.view.frame = rect;
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.collectionView];
}
#pragma mark -- 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.imageView.layer.borderColor = [UIColor purpleColor].CGColor;
    cell.imageView.layer.borderWidth = 2;
    cell.imageView.image = [UIImage imageNamed:@"66"];
    self.cell = cell;
    self.indexPath = indexPath;
    return cell;
}
@end
