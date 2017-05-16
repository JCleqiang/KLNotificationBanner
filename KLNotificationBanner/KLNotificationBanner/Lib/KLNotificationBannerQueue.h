//
//  KLNotificationBannerQueue.h
//  banner
//
//  Created by leqiang222 on 2017/5/2.
//  Copyright © 2017年 静持大师. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLBannerHeader.h"
@class KLBaseNotificationBanner;

@interface KLNotificationBannerQueue : NSObject

+ (instancetype)shareInstance;

/**
 显示下一个 banner

 @param onEmpty 如果队列为空，则关闭执行
 */
- (void)showNext:(void(^)())onEmpty;

/**
 添加一个 banner 到 队列queue

 @param banner        条幅
 @param queuePosition 位置, 如果 queuePosition == QueuePositionFront, 则遵循后进先显示的原则, 先进的暂停;  queuePosition == QueuePositionBack, 则遵循先进先显示完成后再显示后进的
 */
- (void)addBanner:(KLBaseNotificationBanner *)banner queuePosition:(QueuePosition)queuePosition;

@end
