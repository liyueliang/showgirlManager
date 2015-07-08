//
//  YLClearGirlView.h
//  ShowGirl
//
//  Created by lyl on 15/7/5.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLImageModal.h"

@protocol YLClearGirlViewDelegate <NSObject>

@optional
-(void)clearGirlViewClosed;

@end

@interface YLClearGirlView : UIView
//数据模型
@property(nonatomic,strong) YLImageModal *imageModal;
@property(nonatomic,assign) id<YLClearGirlViewDelegate> clearGirlViewDelegate;
@end
