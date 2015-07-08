//
//  YLClearGirlView.m
//  ShowGirl
//
//  Created by lyl on 15/7/5.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLClearGirlView.h"
@interface YLClearGirlView()
@property(nonatomic,weak) UIImageView *newsImageView;
@property(nonatomic,weak) UIImageView *orginImageView;
@property(nonatomic,assign) BOOL ISENBALE;
@end
@implementation YLClearGirlView
 
-(void)setImageModal:(YLImageModal *)imageModal{
    _imageModal =imageModal;
    UIImageView *newsImgaeView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageModal.newsImg]];
    newsImgaeView.frame=self.frame;
    newsImgaeView.userInteractionEnabled=NO;
    newsImgaeView.contentMode=UIViewContentModeScaleToFill;
    [self addSubview:newsImgaeView];
    self.newsImageView =newsImgaeView;
//
    UIImageView *orginImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageModal.orginImg]];
    orginImageView.frame=self.frame;
    orginImageView.userInteractionEnabled=YES;
    orginImageView.contentMode=UIViewContentModeScaleToFill;
    [self addSubview:orginImageView];
    self.orginImageView = orginImageView;
    
    //添加关闭按钮
    UIButton *closeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
   
    CGFloat closeW=30;
    CGFloat closeH=30;
     CGFloat closeX =[[UIScreen mainScreen]bounds].size.width-closeW-5;
    CGFloat closeY=10;
    closeBtn.frame=CGRectMake(closeX,closeY, closeW, closeH);
    [self addSubview:closeBtn];
}
-(void)closeClick:(id)obj{
    [self.clearGirlViewDelegate clearGirlViewClosed];
}
#pragma mark -touch 事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *currentTouch = [touches anyObject];
    if ([currentTouch view]==self.orginImageView) {
        self.ISENBALE =YES;
    }
    }
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.ISENBALE) {
        UITouch *currentTouch =[touches anyObject];
        CGPoint currentPoint =  [currentTouch locationInView:self.orginImageView];
        
        //开启图片上下文
        UIGraphicsBeginImageContext(self.orginImageView.bounds.size);
        [self.orginImageView.image drawInRect:self.orginImageView.bounds];
        CGContextClearRect(UIGraphicsGetCurrentContext(), CGRectMake(currentPoint.x-15, currentPoint.y-15, 30, 30));
        self.orginImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //结束上下文
        UIGraphicsEndImageContext();

    }
   }
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.ISENBALE=NO;
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}




@end
