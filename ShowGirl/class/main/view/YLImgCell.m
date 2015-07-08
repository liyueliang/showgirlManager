//
//  YLImgCell.m
//  ShowGirl
//
//  Created by lyl on 15/7/4.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLImgCell.h"

@implementation YLImgCell
-(void)awakeFromNib{
    self.girlImgView.layer.cornerRadius =8;
    self.girlImgView.clipsToBounds=YES;
}
-(void)setImageModal:(YLImageModal *)imageModal{
    _imageModal =imageModal;
    self.girlImgView.image =[UIImage imageNamed:imageModal.orginImg];
}
@end
