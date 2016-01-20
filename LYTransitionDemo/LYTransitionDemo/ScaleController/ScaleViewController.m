//
//  ScaleViewController.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/24.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "ScaleViewController.h"
#import "CustomCollectionViewLayout.h"
#import "ImageCollectionViewCell.h"
#import "TransitionHelper.h"
#import "ScaleDetailViewController.h"
static const NSInteger dataCount = 50;
static NSString * const reuseIdentifier = @"ImageCellID";
@interface ScaleViewController()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataSourceArray;
@end
@implementation ScaleViewController
-(instancetype)init
{
    CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc]init];
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setImage:_dataSourceArray[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect frame = [collectionView convertRect:cell.frame toView:self.view];
    TransitionHelper *helper = [TransitionHelper sharedInstance];
    helper.transitionType = LYTransitionTypeScale;
    helper.beginFrame = frame;
    self.navigationController.navigationTransition = helper;
    ScaleDetailViewController *destVC = [[ScaleDetailViewController alloc]init];
    destVC.imageName = _dataSourceArray[indexPath.row];
    [self.navigationController pushViewController:destVC animated:YES];
}
@end
