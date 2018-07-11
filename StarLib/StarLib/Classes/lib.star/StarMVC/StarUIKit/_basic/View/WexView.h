//
//  WexView.h
//  WeXFin
//
//  Created by Star on 15/7/20.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"



@protocol WexViewProtocol <NSObject>


/**
 *  加载所有Subview
 *  init时调用，类似loadView
 *  派生类重写应先调用[super wex_loadViews];
 */
- (void)wex_loadViews;

/**
 *  布局所有Subview
 *  wex_loadViews之后调用
 *  正常情况下，派生类重写应先调用[super wex_layoutConstraints];
 */
- (void)wex_layoutConstraints;

@end


@interface WexView : UIView <WexViewProtocol>



@end
