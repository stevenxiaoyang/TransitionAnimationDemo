//
//  ImageCollectionViewCell.h
//  LYTransitionDemo
//
//  Created by LuYang on 15/12/24.
//  Copyright © 2015年 LuYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
-(void)setImage:(NSString *)imageName;
-(UIImageView *)getImageView;
@end
