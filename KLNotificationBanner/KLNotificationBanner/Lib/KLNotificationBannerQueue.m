//
//  KLNotificationBannerQueue.m
//  banner
//
//  Created by leqiang222 on 2017/5/2.
//  Copyright © 2017年 静持大师. All rights reserved.
//

#import "KLNotificationBannerQueue.h"
#import "KLBaseNotificationBanner.h"

@interface KLNotificationBannerQueue ()
/** <#Description#> */
@property (nonatomic, strong) NSMutableArray <KLBaseNotificationBanner *>*bannerArrayM;
@end

@implementation KLNotificationBannerQueue

+ (instancetype)shareInstance {
    static KLNotificationBannerQueue *instance_;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    
    return instance_;
}

- (void)addBanner:(KLBaseNotificationBanner *)banner queuePosition:(QueuePosition)queuePosition {
    switch (queuePosition) {
        case QueuePositionBack: { // 后进的等待显示
            [self.bannerArrayM addObject:banner]; 
            
            if ([self.bannerArrayM indexOfObject:banner] == 0) {
                [banner showPlaceOnQueue:NO queuePosition:queuePosition];
            }
        }
            break;
            
        case QueuePositionFront: { // 后进先显示
            [banner showPlaceOnQueue:NO queuePosition:queuePosition];
            
            if (self.bannerArrayM.count > 0) {
                // 暂停先进的
                [self.bannerArrayM[0] suspend];
            }
            
            [self.bannerArrayM insertObject:banner atIndex:0];
        }
            break;
    }
}

- (void)showNext:(void(^)())onEmpty{
    if (self.bannerArrayM.count == 0) {
        return;
    }
    
    [self.bannerArrayM removeObjectAtIndex:0];
    
    if (self.bannerArrayM.count == 0) {
        if (onEmpty) {
            onEmpty();
        }
        return;
    }
    
    if (self.bannerArrayM.firstObject.isSuspended) {
        [self.bannerArrayM.firstObject resume];
    }else {
        [self.bannerArrayM.firstObject showPlaceOnQueue:NO queuePosition:QueuePositionBack];
    }
}

#pragma mark - Lazy
- (NSMutableArray<KLBaseNotificationBanner *> *)bannerArrayM {
    if (!_bannerArrayM) {
        _bannerArrayM = [NSMutableArray array];
    }
    return _bannerArrayM;
}
@end
