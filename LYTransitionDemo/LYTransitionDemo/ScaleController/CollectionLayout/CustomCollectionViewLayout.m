//
//  CustomCollectionViewLayout.m
//  LYScaleTransition
//
//  Created by YiTe on 15/11/21.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "CustomCollectionViewLayout.h"
@interface CustomCollectionViewLayout()
//存储每列Cell的X坐标
@property (strong, nonatomic) NSMutableArray *cellXArray;
//存储每个cell的随机高度，避免每次加载的随机高度都不同
@property (strong, nonatomic) NSMutableArray *cellHeightArray;
//记录每列Cell的最新Cell的Y坐标
@property (strong, nonatomic) NSMutableArray *cellYArray;
//section的数量
@property (nonatomic) NSInteger numberOfSections;
//section中Cell的数量
@property (nonatomic) NSInteger numberOfCellsInSections;
//瀑布流的行数
@property (nonatomic) NSInteger columnCount;
//cell的最小高度
@property (nonatomic) NSInteger cellMinHeight;
//cell的最大高度，最大高度比最小高度小，以最小高度为准
@property (nonatomic) NSInteger cellMaxHeight;
//cell的宽度
@property (nonatomic) CGFloat cellWidth;
//cell边距
@property (nonatomic) NSInteger padding;
@end
@implementation CustomCollectionViewLayout
#pragma mark - 重写方法
-(void)prepareLayout
{
    [super prepareLayout];
    [self initData];
}

-(CGSize)collectionViewContentSize
{
    CGFloat height = [self maxCellYArrayWithArray:_cellYArray];    
    return CGSizeMake(SCREEN_WIDTH,height);
}

/**
 * 该方法为每个Cell绑定一个Layout属性~
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    
    //add cells
    self.cellYArray = nil;
    for (int i=0; i < _numberOfCellsInSections; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
    }
    
    return array;
}

/**
 * 该方法为每个Cell绑定一个Layout属性~
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect frame = CGRectZero;
    CGFloat cellHeight = [self.cellHeightArray[indexPath.row] floatValue];
    NSInteger minYIndex = [self minCellYArrayWithArray:self.cellYArray];
    CGFloat tempX = [self.cellXArray[minYIndex] floatValue];
    CGFloat tempY = [self.cellYArray[minYIndex] floatValue];
    
    frame = CGRectMake(tempX, tempY, _cellWidth, cellHeight);
    
    //更新相应的Y坐标
    _cellYArray[minYIndex] = @(tempY + cellHeight + _padding);
    
    //计算每个Cell的位置
    attributes.frame = frame;
    
    return attributes;
}

#pragma mark - 懒加载
-(NSMutableArray *)cellHeightArray
{
    if (!_cellHeightArray) {
        _cellHeightArray = [[NSMutableArray alloc]initWithCapacity:_numberOfCellsInSections];
        for (NSInteger i = 0; i < _numberOfCellsInSections; i++) {
            CGFloat cellHeight = arc4random() % (_cellMaxHeight - _cellMinHeight) + _cellMinHeight;
            [_cellHeightArray addObject:@(cellHeight)];
        }
    }
    return _cellHeightArray;
}

-(NSMutableArray *)cellYArray
{
    if (!_cellYArray) {
        _cellYArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
        for (int i = 0; i < _columnCount; i ++) {
            [_cellYArray addObject:@(0)];
        }
    }
    return _cellYArray;
}

-(NSMutableArray *)cellXArray
{
    if (!_cellXArray) {
        //计算每个Cell的宽度
        _cellWidth = (SCREEN_WIDTH - (_columnCount -1) * _padding) / _columnCount;
        
        //为每个Cell计算X坐标
        _cellXArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
        for (int i = 0; i < _columnCount; i ++) {
            CGFloat tempX = i * (_cellWidth + _padding);
            [_cellXArray addObject:@(tempX)];
        }
    }
    return _cellXArray;
}
#pragma mark - private method
-(void)initData
{
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfCellsInSections = [self.collectionView numberOfItemsInSection:0];
    /*
     默认数值
     */
    _columnCount = 3;
    _padding = 0;
    _cellMinHeight = 50;
    _cellMaxHeight = 200;
    if ([_layoutDelegate respondsToSelector:@selector(numberOfColumnWithCollectionView:collectionViewLayout:)]) {
        _columnCount = [_layoutDelegate numberOfColumnWithCollectionView:self.collectionView collectionViewLayout:self];
    }
    if ([_layoutDelegate respondsToSelector:@selector(marginOfCellWithCollectionView:collectionViewLayout:)]) {
        _padding = [_layoutDelegate marginOfCellWithCollectionView:self.collectionView collectionViewLayout:self];
    }
    if ([_layoutDelegate respondsToSelector:@selector(minHeightOfCellWithCollectionView:collectionViewLayout:)]) {
        _cellMinHeight = [_layoutDelegate minHeightOfCellWithCollectionView:self.collectionView collectionViewLayout:self];
    }
    if ([_layoutDelegate respondsToSelector:@selector(maxHeightOfCellWithCollectionView:collectionViewLayout:)]) {
        _cellMaxHeight = [_layoutDelegate maxHeightOfCellWithCollectionView:self.collectionView collectionViewLayout:self];
    }
}

-(CGFloat)maxCellYArrayWithArray:(NSArray *) cellYArray
{
    if (!cellYArray.count) {
        return 0.f;
    }
    else
    {
        CGFloat max = [cellYArray[0] floatValue];
        for (NSNumber *number in cellYArray) {
            CGFloat temp = [number floatValue];
            if (temp > max) {
                max = temp;
            }
        }
        return max;
    }
}

- (CGFloat)minCellYArrayWithArray:(NSMutableArray *) array {
    
    if (array.count == 0) {
        return 0.f;
    }
    
    NSInteger minIndex = 0;
    CGFloat min = [array[0] floatValue];
    
    for (int i = 0; i < array.count; i ++) {
        CGFloat temp = [array[i] floatValue];
        
        if (min > temp) {
            min = temp;
            minIndex = i;
        }
    }
    
    return minIndex;
}

@end
