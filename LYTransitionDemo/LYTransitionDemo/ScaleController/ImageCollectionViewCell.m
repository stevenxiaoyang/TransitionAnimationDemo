//
//  ImageCollectionViewCell.m
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/24.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import "ImageCollectionViewCell.h"
@interface ImageCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@end
@implementation ImageCollectionViewCell
-(void)setImage:(NSString *)imageName
{
    [_cellImageView setImage:[UIImage imageNamed:imageName]];
}

-(UIImageView *)getImageView
{
    return  _cellImageView;
}

@end
