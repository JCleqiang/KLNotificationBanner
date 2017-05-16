//
//  KLNotificationBanner.m
//  banner
//
//  Created by leqiang222 on 2017/5/2.
//  Copyright © 2017年 静持大师. All rights reserved.
//

#import "KLNotificationBanner.h"
#import "UIView+Banner.h"

@interface KLNotificationBanner ()
/** 通知条幅的子标题 */
@property (nonatomic, strong) UILabel *subtitleLabel;
/** 通知条幅的左边视图 */
@property (nonatomic, strong) UIView *leftView;
/** 通知条幅的右边视图 */
@property (nonatomic, strong) UIView *rightView;
@end

@implementation KLNotificationBanner

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle leftView:(UIView *)leftView rightView:(UIView *)rightView style:(BannerStyle)style {
    if (self = [super initWithStyle:style]) {
        // 1.1 左边自定义 view
        CGFloat customWH = kBannerHeight - 20;
        if (leftView) {
            self.leftView = leftView;
            [self.contentView addSubview:self.leftView];
            
            self.leftView.jc_y = 10;
            self.leftView.jc_x = 10;
            self.leftView.jc_height = customWH;
            self.leftView.jc_width = customWH;
        }
        
        NSLog(@"leftView尺寸: %@", NSStringFromCGRect(self.leftView.frame));
        
        // 1.2 右边自定义 view
        if (rightView) {
            self.rightView = rightView;
            [self.contentView addSubview:self.rightView];
            
            self.rightView.jc_y = 10;
            self.rightView.jc_x = self.jc_width - 10 - customWH;
            self.rightView.jc_height = customWH;
            self.rightView.jc_width = customWH;
        }
        
        NSLog(@"rightView尺寸: %@", NSStringFromCGRect(self.rightView.frame));
    
        // 2.标题容器
        UIView *labelsView = [[UIView alloc] init]; 
        [self.contentView addSubview:labelsView];
        
        if (leftView) {
            labelsView.jc_x = self.leftView.jc_right + kSubPadding;
        }else {
            labelsView.jc_x = kSubPadding;
        }
        
        labelsView.jc_width = self.jc_width - (!!leftView + !!rightView) * customWH - (!!leftView + !!rightView + 2) * kSubPadding; 
        
        NSLog(@"labelsView尺寸: %@", NSStringFromCGRect(labelsView.frame));

        // 2.1 主标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:17.5 weight:UIFontWeightBold];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = title;
        
        [labelsView addSubview:self.titleLabel];
        
        self.titleLabel.jc_width = labelsView.jc_width;
        self.titleLabel.jc_height = 17.5;
        self.titleLabel.jc_x = 0;
        self.titleLabel.jc_y = 0;
        if (subtitle) {
            self.titleLabel.numberOfLines = 1;
        }else {
            self.titleLabel.numberOfLines = 2;
        }
//        [self.titleLabel sizeToFit];
        
        NSLog(@"titleLabel尺寸: %@", NSStringFromCGRect(self.titleLabel.frame));
        
        // 2.2 子标题
        if (subtitle) {
            self.subtitleLabel = [[UILabel alloc] init];
            self.subtitleLabel.font = [UIFont systemFontOfSize:15];
            self.subtitleLabel.numberOfLines = 1;
            self.subtitleLabel.textColor = [UIColor whiteColor];
            self.subtitleLabel.text = subtitle;
            self.subtitleLabel.numberOfLines = 1;
            
            [labelsView addSubview:self.subtitleLabel];
            
            self.subtitleLabel.jc_width = labelsView.jc_width;
            self.subtitleLabel.jc_height = 15;
            self.subtitleLabel.jc_y = self.titleLabel.jc_bottom + 2.5;
            self.subtitleLabel.jc_x = 0;
//            [self.subtitleLabel sizeToFit];
        }
        
        NSLog(@"yy: %@", NSStringFromCGRect(self.subtitleLabel.frame));
        
        if (subtitle) {
            labelsView.jc_height = self.subtitleLabel.jc_bottom - self.titleLabel.jc_x;
        }else {
            labelsView.jc_height = self.titleLabel.jc_height;
        }
        labelsView.jc_centerY = kBannerHeight * 0.5;
        
        NSLog(@"最终: labelsView尺寸: %@", NSStringFromCGRect(labelsView.frame));
    }
    
    return self;
}

@end
