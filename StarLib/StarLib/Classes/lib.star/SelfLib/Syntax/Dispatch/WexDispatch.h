//
//  WexDispatch.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/31.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#ifndef WexDispatch_h
#define WexDispatch_h


static inline void dispatch_delay(NSTimeInterval delay, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

static inline void dispatch_delay_q(NSTimeInterval delay, dispatch_queue_t queue, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), queue, block);
}


inline static void dispatch_main_async(dispatch_block_t block) {
//    if ([NSThread isMainThread]) {
//        block();
//      既然是async 还是要用异步的方式来执行
//    }
//    else {
        dispatch_async(dispatch_get_main_queue(), block);
//    }
}


#endif /* WexDispatch_h */
