//
//  MovingCollectionViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/24.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "MovingViewController.h"
#import "ImageCollectionViewCell.h"
#import "MovingDetailViewController.h"
#import "TransitionHelper.h"
static NSString * const reuseIdentifier = @"ImageCellID";
static const NSInteger dataCount = 50;
static const CGFloat Item_Spacing = 10.f;
@interface MovingViewController ()
@property (nonatomic,strong)NSMutableArray *dataSourceArray;
@end

@implementation MovingViewController
-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((SCREEN_WIDTH - Item_Spacing*4)/3, (SCREEN_WIDTH - Item_Spacing*4)/3);
    layout.minimumInteritemSpacing = Item_Spacing;
    layout.minimumLineSpacing = Item_Spacing;
    return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    /*
     模拟数据源
     */
    _dataSourceArray = [[NSMutableArray alloc]initWithCapacity:dataCount];
    for (NSInteger i = 0; i < dataCount; i++) {
        NSInteger imageIndex = arc4random() % 10;
        NSString *imageName = [NSString stringWithFormat:@"00%ld.jpg", imageIndex];
        [_dataSourceArray addObject:imageName];
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setImage:_dataSourceArray[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [collectionView convertRect:cell.frame toView:self.view];
    TransitionHelper *helper = [TransitionHelper sharedInstance];
    helper.transitionType = LYTransitionTypeMove;
    helper.beginFrame = frame;
    helper.indexPath = indexPath;
    self.navigationController.navigationTransition = helper;
    MovingDetailViewController *destVC = [MovingDetailViewController new];
    destVC.imageName = _dataSourceArray[indexPath.row];
    [self.navigationController pushViewController:destVC animated:YES];

}

#pragma mark - Public Methods
-(UIImageView *)getImageViewAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    return [cell getImageView];
}
@end
