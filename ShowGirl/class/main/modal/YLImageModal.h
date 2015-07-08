//
//  YLImageModal.h
//  ShowGirl
//
//  Created by lyl on 15/7/4.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLImageModal : NSObject
@property(nonatomic,copy) NSString *orginImg;
@property(nonatomic,copy) NSString *newsImg;
+(instancetype)imageModalWithDict:(NSDictionary *)dict; 
@end
