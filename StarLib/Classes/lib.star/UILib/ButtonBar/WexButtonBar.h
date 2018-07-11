//
//  WexButtonBar.h
//  WeicaifuForQXSDK
//
//  Created by 星星 on 2017/12/26.
//

#import <Foundation/Foundation.h>

@interface WexButtonBar : WexView

@property (nonatomic, weak) UIView *contentView;

+ (WexButtonBar *)createButtonBarInView:(UIView *)view;

@end
