//
//  KLBaseNotificationBanner.h
//  banner
//
//  Created by leqiang222 on 2017/5/2.
//  Copyright © 2017年 静持大师. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLBannerHeader.h"
#import "KLNotificationBannerQueue.h"

typedef void(^OnTap)();
typedef void(^OnSwipeUp)();

static CGFloat const kBannerHeight = 64.f; // 条幅高度
static CGFloat const kSubPadding = 10.f; // 子控件之间的间距

@interface KLBaseNotificationBanner : UIView

#pragma mark - 属性
/**
 *  banner 动画显示的时间
 *  default is 5秒
 */
@property (nonatomic, assign) NSTimeInterval duration; 

/**
 *  内容容器 view
 */
@property (nonatomic, strong) UIView *contentView;

/**
 *  主标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  点击 banner 是否消失
 *  default is YES
 */
@property (nonatomic, assign) BOOL dismissOnTap;

/**
 *  拖拽 banner 是否消失
 *  default is YES
 */
@property (nonatomic, assign) BOOL dismissOnSwipeUp;


/**
 *  banner 点击的 block 回调
 */
@property (nonatomic, copy) OnTap onTap;

/**
 *  banner 往上拖拽的 block 回调
 */
@property (nonatomic, copy) OnSwipeUp onSwipeUp;

/**
 *  由 banner 队列使用，以确定队列中是否将通知标志置于其前面
 */
@property (nonatomic, assign) BOOL isSuspended;


#pragma mark - Public Method
/**
 初始化一个 banner

 @param bannerStyle banner 背景样式

 @return KLBaseNotificationBanner
 */
- (instancetype)initWithStyle:(BannerStyle)bannerStyle;

/**
 顶部显示通知横幅

 @param placeOnQueue  横幅显示的等待队列
                      传 YES, 横幅需要队列等待: 表示队列中下一个要显示的横幅要等正在显示的横幅消失才会出现;
                      传 NO, 横幅不需要队列等待: 表示队列中下一个要显示的横幅会覆盖正在显示的横幅
                      default is NO
 @param queuePosition 显示位置
 */
- (void)showPlaceOnQueue:(BOOL)placeOnQueue queuePosition:(QueuePosition)queuePosition;
- (void)show;

/**
 *  暂停
 */
- (void)suspend;

/**
 *  恢复
 */
- (void)resume;

@end
