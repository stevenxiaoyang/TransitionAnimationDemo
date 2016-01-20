//
//  CustomCollectionViewLayout.h
//  LYScaleTransition
//
//  Created by YiTe on 15/11/21.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomCollectionViewLayout;
@protocol CustomCollectionViewLayoutDelegate<NSObject>
@optional
/**
 * 确定布局行数的回调
 */
@required
- (NSInteger)numberOfColumnWithCollectionView:(UICollectionView *)collectionView
                         collectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout;

/**
 * 确定cell的Margin
 */
@required
- (CGFloat)marginOfCellWithCollectionView:(UICollectionView *)collectionView
                     collectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout;
/**
 * 确定cell的最小高度
 */
@required
- (CGFloat)minHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout;

/**
 * 确定cell的最大高度
 */
@required
- (CGFloat)maxHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:(CustomCollectionViewLayout *)collectionViewLayout;

@end
@interface CustomCollectionViewLayout : UICollectionViewLayout
@property(nonatomic,weak)id<CustomCollectionViewLayoutDelegate> layoutDelegate;
@end
