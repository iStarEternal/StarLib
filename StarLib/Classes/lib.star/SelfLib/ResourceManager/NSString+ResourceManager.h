//
//  NSString+ResManager.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString(ResourceManager)

@property (nonatomic, strong, readonly) UIFont *xc_font;

@property (nonatomic, strong, readonly) UIColor *xc_color;
@property (nonatomic, strong, readonly) UIColor *(^xc_colorWithAlpha)(CGFloat alpha);

@property (nonatomic, strong, readonly) UIImage *xc_image;
// @property (nonatomic, strong, readonly) UIImage *xc_resizableImage;


@end


@interface UILabel (AmountAdvanceDecline) {}

@property (nonatomic, strong) NSString *xc_changeAmount;

@end
