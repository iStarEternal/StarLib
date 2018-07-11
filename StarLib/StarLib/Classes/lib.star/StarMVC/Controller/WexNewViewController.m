//
//  WexNewViewController.m
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexNewViewController.h"


@interface WexNewViewController()

@property (nonatomic) PythiaNavBarLeftButtonType leftButtonType;

@end

@implementation WexNewViewController

- (void)dealloc {
    LogSuccess(@"%@ [%@.m:0] Dealloc.", self, NSStringFromClass([self class]));
}



#pragma mark - 页面状态

- (BOOL)popGestureEnabled {
    return true;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (!self.navBar)
        return UIStatusBarStyleDefault;
    
    switch (self.navBar.type) {
        case PythiaNavBarTypeWCFRed:
        case PythiaNavBarTypeWCFGold: {
            
            if ([NSString isNullOrWhiteSpace:self.navBar.ruleHint]) {
                return UIStatusBarStyleLightContent;
            }
            else {
                return UIStatusBarStyleDefault;
            }
        }
            break;
            
        default:
            return UIStatusBarStyleDefault;
            break;
    }
    
    return UIStatusBarStyleLightContent;
}


#pragma mark - 加载

- (void)wex_loadNavigationBar {
    
    PythiaNavBar *navBar = [PythiaNavBarHelper installNavBarInView:self.view];
    self.navBar = navBar;
    self.navBar.delegate = self;
    [self setNavBarTitle:self.title];
    [self setNavBarType:PythiaNavBarTypeLight];
    [self setNavBarLeftButtonType:PythiaNavBarLeftButtonTypeBack];
}

- (void)wex_loadViews {
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self wex_loadBottomView];
}

- (void)wex_loadButtonBar {
    self.buttonBar = [WexButtonBar createButtonBarInView:self.view];
}

- (void)wex_layoutConstraints {
    
}



- (void)wex_loadBottomView {
    
}


#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *className = NSStringFromClass([self class]);
    LogSuccess(@"%@ [%@.m:0] viewDidLoad.", self, className);
    
    [self wex_loadNavigationBar];
    [self wex_loadViews];
    [self wex_layoutConstraints];
    
    _loading = [[WexLoadingHelper alloc] initWithHandleView:self.view delegate:self];
    self.keyboardHelper = [[KeyboardHelper alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [WexUMClick beginLogPageViewWithClass:[self class]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // [WexUMClick endLogPageViewWithClass:[self class]];
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - NavBar

- (void)setNavBarType:(PythiaNavBarType)type {
    [PythiaNavBarHelper initNavBar:self.navBar type:type];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setNavBarLeftButtonType:(PythiaNavBarLeftButtonType)leftButtonType {
    [PythiaNavBarHelper initNavBar:self.navBar leftButtonType:leftButtonType];
    self.leftButtonType = leftButtonType;
}

- (void)setNavBarLeftSecondButtonTitle:(NSString *)title {
    [PythiaNavBarHelper initNavBar:self.navBar leftSecondButtonTitle:title];
}

- (void)setNavBarRightButtonType:(PythiaNavBarRightButtonType)rightButtonType {
    [PythiaNavBarHelper initNavBar:self.navBar rightButtonType:rightButtonType];
}

- (void)setNavBarRightButtonTitle:(NSString *)title {
    [PythiaNavBarHelper initNavBar:self.navBar rightButtonTitle:title];
}

- (void)setNavBarRightImage:(UIImage *)image {
    [self.navBar clearRightButton];
    self.navBar.rightButton.hidden                  = false;
    self.navBar.rightButton.userInteractionEnabled  = true;
    self.navBar.rightButton.wex_font                = @"15px".xc_font;
    self.navBar.rightButton.wex_normalImage         = image;
    self.navBar.rightButton.wex_normalBackgroundImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(50, 44)];
}

- (void)setNavBarTitle:(NSString *)title {
    self.title = title;
}

- (void)setNavBarHidden:(BOOL)hidden {
    self.navBar.hidden = hidden;
}

- (void)setTitle:(NSString *)title {
    super.title = title;
    [PythiaNavBarHelper initNavBar:self.navBar title:title];
}



#pragma mark - PythiaNavBarDelegate

- (void)wex_navBarLeftButtonClicked:(id)sender {
    if (self.leftButtonType == PythiaNavBarLeftButtonTypeBack
        || self.leftButtonType == PythiaNavBarLeftButtonTypeCancel
        || self.navBar.leftButtonType == PythiaNavBarLeftButtonTypeBack) {
        [self.navigationServices popViewControllerAnimated:true];
    }
}

- (void)wex_navBarLeftSecondButtonClicked:(id)sender {
    
}

- (void)wex_navBarRightButtonClicked:(id)sender {
    
}




#pragma mark - 键盘处理逻辑

// 是否启用键盘默认处理逻辑,默认启用
- (BOOL)isUseDefaultKeyboardHandle {
    return YES;
}

- (void)keyboardHelper:(KeyboardHelper *)keyboardHelper showWithFrame:(CGRect)keybordFrame duration:(NSTimeInterval)duration {
    
}

- (void)keyboardHelper:(KeyboardHelper *)keyboardHelper hideWithFrame:(CGRect)keybordFrame duration:(NSTimeInterval)duration {
    
}



#pragma mark - loading delegate

- (void)wex_loadingAction {
    if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(viewController:loadingWithParameters:)]) {
        [self.dataDelegate viewController:self loadingWithParameters:nil];
    }
}

- (void)wex_loadingGoBackClicked {
    [self.navigationServices popViewControllerAnimated:true];
}



#pragma mark - loading 赋值

- (void)setLoadingSuccess:(id)data {
    _viewData = data;
    if ([self.loading isLoading]) {
        [self.loading endLoading];
    }
}

- (void)setLoadingFailure:(NSError *)error {
    NSString *msg = error.msg ?: @"数据加载失败，请稍后再试";
    // 如果没有数据
    if (!self.viewData) {
        // 网络错误 <= NSURLErrorCancelled
        if (error.code < 0) {
            [self.loading loadingFailureNetwork];
            ShowInfoHUD(msg);
        }
        // 服务器错误
        else {
            [self.loading loadingFailureNormal:msg];
        }
    }
    // 如果有数据
    else {
        [self.loading endLoading];
        ShowInfoHUD(msg);
    }
}

@end


