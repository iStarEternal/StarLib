//
//  WexLoadingView.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/5/16.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexLoadingView.h"


@interface WexLoadingView () {}

@property (nonatomic, weak) UIActivityIndicatorView *anmView;
@property (nonatomic, weak) UILabel *loadingTitle;

@property (nonatomic, weak) UIControl *failureView;
@property (nonatomic, weak) UIImageView *failureImageView;
@property (nonatomic, weak) UILabel *failureLabel;

@property (nonatomic, weak) UIButton *goBackButton;

@end

@implementation WexLoadingView

- (void)wex_loadViews {
    [super wex_loadViews];
    
    // self.backgroundColor = @"#F7F8F9".xc_color;
    self.backgroundColor = @"#000000".xc_colorWithAlpha(0.05);
    
    {
        UIActivityIndicatorView *anmView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:anmView];
        self.anmView = anmView;
        [anmView startAnimating];
        anmView.color = @"#000000".xc_colorWithAlpha(0.5);
     
        UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage roundImageWithColor:@"#FFFFFF".xc_color size:CGSizeMake(35, 35)]];
        [self addSubview:imgv];
        imgv.layer.shadowColor = @"#000000".xc_color.CGColor;
        imgv.layer.shadowRadius = 3;
        imgv.layer.shadowOffset = CGSizeMake(-1, 2);
        imgv.layer.shadowOpacity = 0.2;
        [anmView bringToFront];
        [imgv makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(anmView);
        }];
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        label.textColor     = rgba(165,165,165,1);
        label.font          = @"15px".xc_font;
        label.textAlignment = NSTextAlignmentCenter;
        label.hidden = true;
        [self addSubview:label];
        self.loadingTitle = label;
    }
    
    
    {
        UIControl *control = [[UIControl alloc] init];
        control.backgroundColor = [UIColor whiteColor];
        control.hidden = true;
        [self addSubview:control];
        self.failureView = control;
    }
    
    {
        UIImageView *imgv = [[UIImageView alloc] init];
        imgv.image  = @"icon_loading_failure".xc_image;
        [self.failureView addSubview:imgv];
        self.failureImageView = imgv;
    }
    
    {
        UILabel *label = [[UILabel alloc] init];
        label.text      = @"网络不给力，轻触屏幕刷新";
        label.textColor = rgba(165,165,165,1);
        label.font      = @"15px".xc_font;
        [self.failureView addSubview:label];
        self.failureLabel = label;
    }
    
    {
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        self.goBackButton = button;
        self.goBackButton.wex_normalImage  = nil;//@"wcf_navbar_btn_back".xc_image.templateImage;
        button.tintColor        = @"#999999".xc_color;
    }
}

- (void)wex_layoutConstraints {
    
    
    [self.anmView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(-20);
    }];
    
    
    [self.failureView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
    
    [self.failureImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(-100);
    }];
    
    [self.failureLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(self.failureImageView.mas_bottom).offset(30);
    }];
    
    [self.goBackButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(2);
        make.top.equalTo(StatusBarHeight);
        make.size.equalTo(44);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


#pragma mark - 实现接口

- (void)setLoading:(NSString *)title {
    
    self.backgroundColor = @"#000000".xc_colorWithAlpha(0.05);
    self.anmView.hidden         = false;
    self.loadingTitle.hidden    = false;
    self.loadingTitle.text      = title;
    
    self.failureView.hidden     = true;
    self.goBackButton.wex_normalImage  = nil;
}

- (void)setLoadingFailureNormal:(NSString *)title {
    
    self.backgroundColor = @"#F7F8F9".xc_color;
    self.anmView.hidden         = true;
    self.loadingTitle.hidden    = true;
    
    self.failureView.hidden     = false;
    self.failureImageView.image = @"icon_loading_failure_wcf".xc_image;
    self.failureLabel.text      = title;
    self.goBackButton.wex_normalImage  = @"wcf_navbar_btn_back".xc_image.templateImage;
}

- (void)setLoadingFailureNetwork:(NSString *)title {
    
    self.backgroundColor = @"#F7F8F9".xc_color;
    self.anmView.hidden         = true;
    self.loadingTitle.hidden    = true;
    
    self.failureView.hidden     = false;
    self.failureImageView.image = @"icon_loading_failure_wcf".xc_image;
    self.failureLabel.text      = title;
    
    self.goBackButton.wex_normalImage  = @"wcf_navbar_btn_back".xc_image.templateImage;
}


- (void)setGoBackHidden:(BOOL)goBackHidden {
    self.goBackButton.hidden = goBackHidden;
    
}

- (BOOL)goBackHidden {
    return self.goBackButton.hidden;
}

#pragma mark -

- (void)addFailureTouchHandlerWithTarget:(id)target action:(SEL)action {
    [self.failureView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)addGoBackButtonHandlerWithTarget:(id)target action:(SEL)action {
    [self.goBackButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
