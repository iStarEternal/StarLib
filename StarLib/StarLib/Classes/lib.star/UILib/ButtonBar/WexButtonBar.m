//
//  WexButtonBar.m
//  WeicaifuForQXSDK
//
//  Created by 星星 on 2017/12/26.
//

#import "WexButtonBar.h"

@implementation WexButtonBar

- (void)wex_loadViews {
    [super wex_loadViews];
    self.backgroundColor = @"#FFFFFF".xc_colorWithAlpha(0.7);
    
    UIView *v = [[UIView alloc] init];
    self.contentView = v;
    [self addSubview:v];
    
    if (is_iPhoneX) {
        v.layer.cornerRadius = 4;
        v.layer.masksToBounds = true;
    }
}

- (void)wex_layoutConstraints {
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(44);
        make.top.equalTo(is_iPhoneX ? 15 : 0);
        make.left.equalTo(is_iPhoneX ? 15 : 0);
        make.right.equalTo(is_iPhoneX ? -15 : 0);
    }];
}


+ (WexButtonBar *)createButtonBarInView:(UIView *)view {
    WexButtonBar *bb = [[WexButtonBar alloc] init];
    bb.frame = CGRectMake(0, 0 , ScreenWidth, is_iPhoneX ? 78 : 44);
    [view addSubview:bb];
    [bb makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(is_iPhoneX ? 78 : 44);
    }];
    return bb;
}

@end
