//
//  KLNotificationBanner.h
//  banner
//
//  Created by leqiang222 on 2017/5/2.
//  Copyright © 2017年 静持大师. All rights reserved.
//

#import "KLBaseNotificationBanner.h"
#import "KLBannerHeader.h"

@interface KLNotificationBanner : KLBaseNotificationBanner

/**
 初始化一个通知条幅

 @param title     标题
 @param subtitle  子标题
 @param leftView  左边自定义视图
 @param rightView 右边自定义视图
 @param style     条幅背景样式

 @return KLNotificationBanner
 */
- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle leftView:(UIView *)leftView rightView:(UIView *)rightView style:(BannerStyle)style;

//- (instancetype)initWithCustomView:(UIView *)customView;

@end
