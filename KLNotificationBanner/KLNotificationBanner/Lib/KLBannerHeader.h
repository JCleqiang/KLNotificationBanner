//
//  JCBannerHeader.h
//  banner
//
//  Created by leqiang222 on 2017/5/2.
//  Copyright © 2017年 静持大师. All rights reserved.
//

#ifndef JCBannerHeader_h
#define JCBannerHeader_h


typedef NS_ENUM(NSUInteger, QueuePosition) { // 队列中 banner 的显示类型
    QueuePositionBack, // 遵循先进先显示 先进的完成后再显示后进的(也就是说一个接着一个显示)
    QueuePositionFront, // 遵循后进先显示的原则, 先进的此时暂停
};

typedef NS_ENUM(NSUInteger, BannerStyle) {
    BannerStyleDanger,
    BannerStyleInfo,
    BannerStyleNone,
    BannerStyleSuccess,
    BannerStyleWarning,
};


#endif /* KLBannerHeader_h */
