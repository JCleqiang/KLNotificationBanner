//
//  KLBaseNotificationBanner.m
//  banner
//
//  Created by leqiang222 on 2017/5/2.
//  Copyright © 2017年 静持大师. All rights reserved.
//

#import "KLBaseNotificationBanner.h"
#import "UIView+Banner.h"

#define KLColor(r, g, b)  [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:1.0]

@interface KLBaseNotificationBanner ()


/** 缓冲动画效果的控件 */
@property (nonatomic, strong) UIView *spacerView;
/** 窗口 */
@property (nonatomic, strong) UIWindow *APP_WINDOW;

/** 负责通知 banner 的定位和自动管理 */
@property (nonatomic, strong) KLNotificationBannerQueue *bannerQueue;

@end

@implementation KLBaseNotificationBanner

- (instancetype)initWithStyle:(BannerStyle)bannerStyle {
    
    if (self = [super init]) {
        self.duration = 5;
        self.dismissOnTap = YES;
        self.dismissOnSwipeUp = YES; 
        self.isSuspended = NO;
        self.bannerQueue = [KLNotificationBannerQueue shareInstance];
        self.APP_WINDOW = [UIApplication sharedApplication].keyWindow;
        
        self.jc_width = self.APP_WINDOW.jc_width;
        
        //
        self.spacerView = [[UIView alloc] init];
        [self addSubview:self.spacerView];
        
        self.spacerView.jc_height = 10;
        self.spacerView.jc_width = self.APP_WINDOW.jc_width;
        self.spacerView.jc_y = -10;
        self.spacerView.jc_x = 0;
        
        //
        self.contentView = [[UIView alloc] init];
        [self addSubview:self.contentView];
        
        self.contentView.jc_width = self.APP_WINDOW.jc_width;
        self.contentView.jc_height = kBannerHeight;
        self.contentView.jc_y = 0;
        self.contentView.jc_x = 0;
        
        UIColor *bgColor = nil;
        switch (bannerStyle) {
            case BannerStyleDanger: bgColor = KLColor(0.90, 0.31, 0.31); break;
            case BannerStyleInfo:   bgColor = KLColor(0.23, 0.60, 0.85); break;
            case BannerStyleNone:   bgColor = [UIColor clearColor]; break;
            case BannerStyleSuccess: bgColor = KLColor(0.22, 0.80, 0.46); break;
            case BannerStyleWarning: bgColor = KLColor(1.00, 0.66, 0.16); break;
        }
        self.backgroundColor = bgColor;
        
        // 手势
        UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeUpGestureRecognizer)];
        swipeGes.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:swipeGes];
        
        //
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOrientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action
/**
 *  通知条幅向上拖拽
 */
- (void)onSwipeUpGestureRecognizer {
    if (self.dismissOnSwipeUp) {
        [self dismiss];
        
        if (self.onSwipeUp) {
            self.onSwipeUp();
        }
    }
}

/**
 *  通知条幅被点击
 */
- (void)onTapGestureRecognizer {
    if (self.dismissOnTap) {
        [self dismiss];
        
        if (self.onTap) {
            self.onTap();
        }
    }
}

#pragma mark - 通知
- (void)onOrientationChanged {
    self.jc_width = self.APP_WINDOW.jc_width;
}

#pragma mark - Private
/**
 *  隐藏当前条幅并且显示队列中的下一个条幅
 */
- (void)dismiss {
    //
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    
    //
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, - self.jc_height, self.jc_width, self.jc_height);
    } completion:^(BOOL finished) {
        if (self.APP_WINDOW.subviews.count <= 2) {
            self.APP_WINDOW.windowLevel = UIWindowLevelNormal;
        }

        [self removeFromSuperview];
        [self.bannerQueue showNext:^{
            self.APP_WINDOW.windowLevel = UIWindowLevelNormal;
        }];
    }];
}

#pragma mark - Public
- (void)show {
    [self showPlaceOnQueue:NO queuePosition:QueuePositionBack];
}

- (void)showPlaceOnQueue:(BOOL)placeOnQueue queuePosition:(QueuePosition)queuePosition {
    // 1.将 banner 添加到队列中
    if (placeOnQueue) {
        [self.bannerQueue addBanner:self queuePosition:queuePosition];
       
    // 2.将 banner 添加到 window 上, 显示动画和点击事件
    }else {
        self.frame = CGRectMake(0, - kBannerHeight, self.APP_WINDOW.jc_width, kBannerHeight);
        [self.APP_WINDOW addSubview:self];
        self.APP_WINDOW.windowLevel = UIWindowLevelStatusBar + 1;
        
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = CGRectMake(0, 0, self.jc_width, self.jc_height);
            
        } completion:^(BOOL finished) {
            // banner 的点击事件
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGestureRecognizer)];
            [self addGestureRecognizer:tapGes];
            
            //
            if (!self.isSuspended) {
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.duration];
            }
        }];
    }
}

- (void)suspend {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    self.isSuspended = YES;
}

- (void)resume {
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.duration];
    self.isSuspended = NO;
}

#pragma mark - Setter

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    
    self.contentView.backgroundColor = backgroundColor;
    self.spacerView.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
    [super backgroundColor];
    
    return self.contentView.backgroundColor;
}
@end
