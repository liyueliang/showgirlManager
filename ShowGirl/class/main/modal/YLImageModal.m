//
//  YLImageModal.m
//  ShowGirl
//
//  Created by lyl on 15/7/4.
//  Copyright (c) 2015年 lyl. All rights reserved.
//

#import "YLImageModal.h"

@implementation YLImageModal
+(instancetype)imageModalWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self ==[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(NSString *)description{
     
    return [NSString stringWithFormat:@"newsImg:%@ orginImg:%@",self.newsImg,self.orginImg];
}
@end
