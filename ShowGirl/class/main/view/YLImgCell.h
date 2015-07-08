//
//  YLImgCell.h
//  ShowGirl
//
//  Created by lyl on 15/7/4.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLImageModal.h"
@interface YLImgCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *girlImgView;
//模型数据
@property(nonatomic,strong) YLImageModal *imageModal;
@end
