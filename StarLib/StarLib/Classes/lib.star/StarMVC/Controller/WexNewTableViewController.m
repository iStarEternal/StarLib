//
//  WexNewTableViewController.m
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexNewTableViewController.h"

@interface WexNewTableViewController ()

@property (nonatomic) CGSize keyboardSize; // 键盘尺寸
@property (nonatomic) CGSize originContentSize;

@end

@implementation WexNewTableViewController


- (UITableViewStyle)wex_tableViewStyle {
    return UITableViewStylePlain;
}

#pragma mark - 页面构造

- (void)wex_loadNavigationBar {
    [super wex_loadNavigationBar];
}

- (void)wex_loadViews {
    [super wex_loadViews];
    
    // 用来解决iOS7-iOS8系统中 Tabbar NavigationBar合用时automaticallyAdjustsScrollViewInsets出现的问题
    // 请勿改变控件顺序z-index，切记
    WexView *tableViewAdhereView = [[WexView alloc] init];
    [self.view addSubview:tableViewAdhereView];
    
    WexTableView *tableView = [[WexTableView alloc] initWithFrame:CGRectZero style:[self wex_tableViewStyle]];
    [self.view addSubview:tableView];
    _tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor      = [UIColor clearColor];
    self.tableView.separatorStyle       = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.estimatedRowHeight   = 44;
    self.tableView.rowHeight            = UITableViewAutomaticDimension;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    [tableViewAdhereView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.tableView);
        make.height.equalTo(0).priorityHigh();
    }];
    
    [self wex_loadStaticTableViewCell];
    
    self.clearsSelectionOnViewWillAppear = true;
    
    [self.navBar bringToFront];
}

- (void)wex_loadButtonBar {
    [super wex_loadButtonBar];
    self.tableView.contentInsetBottom = self.buttonBar.height;
}

- (void)wex_layoutConstraints {
    [super wex_layoutConstraints];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo((self.navBar && !self.navBar.hidden) ? self.navBar.mas_bottom : self.view.mas_top).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    _refresh = [[XCRefreshHelper alloc] initWithHandleScrollView:self.tableView delegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.clearsSelectionOnViewWillAppear) {
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:true];
    }
    
    if ([self isUseDefaultKeyboardHandle]) {
        [self.keyboardHelper addKeyboardObserver];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self isUseDefaultKeyboardHandle]) {
        [self.keyboardHelper removeKeyboardObserver];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark - WexTableViewDelegate

- (void)wex_tableViewTouchesBegan:(WexTableView *)sender {
    if (sender == self.tableView) {
        [self.view endEditing:YES];
    }
}


#pragma mark - UITableView

- (void)wex_loadStaticTableViewCell {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
}



#pragma mark - Keyboard Methods

- (void)keyboardHelper:(KeyboardHelper *)keyboardHelper showWithFrame:(CGRect)keybordFrame duration:(NSTimeInterval)duration {
    // 防止重入，可以改进
    if (CGSizeEqualToSize(self.keyboardSize, CGSizeZero)) {
        self.originContentSize = self.tableView.contentSize;
        self.keyboardSize = keybordFrame.size;
        [self keyboardShowScrollTableView:self.tableView duration:duration];
    }
}

- (void)keyboardHelper:(KeyboardHelper *)keyboardHelper hideWithFrame:(CGRect)keybordFrame duration:(NSTimeInterval)duration {
    CGFloat height = MAX(self.originContentSize.height, self.tableView.contentSize.height - self.keyboardSize.height);
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, height);
    self.keyboardSize = CGSizeZero;
}

- (BOOL)keyboardShowScrollTableView:(UITableView *)tableView duration:(NSTimeInterval)duration {
    
    // 键盘的处理参考:
    // https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
    // 1. 不使用contentInsets的方式是因为在iOS7&iOS7+，输入框会随着contentInsets自动调整到不被键盘遮挡
    //    但是在iOS7-中需要我们自己做调整，所有在这里使用调整contentSize的方式处理，保证在不同版本系统中的处理方式一致
    
    // 在这里根据键盘高度调整contentSize实际是偏大的
    
    // 获得输入焦点，使用了“黑科技”
    // http://stackoverflow.com/questions/5029267/is-there-any-way-of-asking-an-ios-view-which-of-its-children-has-first-responder/14135456#14135456
    UIView *responderView = [UIResponder wex_currentFirstResponder];
    
    
    if (![responderView isKindOfClass:[UITextField class]] && ![responderView isKindOfClass:[UITextView class]]) {
        return false;
    }
    
    if (![responderView isDescendantOfView:self.tableView]) {
        return false;
    }
    
    tableView.contentSize = CGSizeMake(tableView.contentSize.width, tableView.contentSize.height + self.keyboardSize.height);
    // Offset with tableview
    CGPoint point = [responderView convertPoint:CGPointMake(0, responderView.frame.size.height) toView:tableView];
    
    if ((point.y + self.keyboardSize.height) < CGRectGetHeight(tableView.frame)) {
        return false;
    }
    
    point.y -= 30.0;
    CGFloat maxPointY = tableView.contentSize.height - CGRectGetHeight(tableView.frame);
    CGFloat toPointY = (point.y > maxPointY) ? maxPointY : point.y;
    
    [UIView animateWithDuration:duration animations:^{
        // 最多移到底部，使得后续的滑动平顺
        tableView.contentOffset = CGPointMake(0, toPointY);
    }];
    
    return true;
}



#pragma mark - 刷新事件

- (void)wex_refreshHeaderAction:(XCRefreshHelper *)refresh {
    [self.dataDelegate viewController:self loadingWithParameters:nil];
}

- (void)wex_refreshFooterAction:(XCRefreshHelper *)refresh {
    [self.dataDelegate viewController:self loadingWithParameters:nil];
}

- (void)setLoadingSuccess:(id)data {
    [super setLoadingSuccess:data];
    
    // 缓存
//    if ([data isKindOfClass:[PythiaDataEntity class]]) {
//        if ([data isCache]) {
//            return;
//        }
//    }
    
    // 下拉刷新
    if (self.refresh.isHeaderRefreshing) {
        [self.refresh endHeaderRefreshing];
    }
    // 上拉刷新
    if (self.refresh.isFooterRefreshing) {
        [self.refresh endFooterRefreshing];
    }
}

- (void)setLoadingFailure:(NSError *)error {
    
    // 页面加载
    if (self.loading.isLoading) {
        [super setLoadingFailure:error];
    }
    
    // 下拉刷新
    else if (self.refresh.isHeaderRefreshing) {
        [super setLoadingFailure:error];
        [self.refresh endHeaderRefreshing];
    }
    
    // 上拉刷新，直接提示错误
    else if (self.refresh.isFooterRefreshing) {
        [self.refresh endFooterRefreshing];
        ShowInfoHUD(error.msg ?: @"数据加载失败，请稍后再试");
    }
    
    // 其他情况，可能是没有触发刷新动作的后台刷新
    else {
        ShowInfoHUD(error.msg ?: @"数据加载失败，请稍后再试");
    }
}






// --------------------------------------------------------------------------
#pragma mark - 微财富遗留

#pragma mark scroll 特效

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
//        // 下拉刷新隐藏navigationBar
//        if ([self headerRefreshingEffect]) {
//
//            CGPoint contentOffset = scrollView.contentOffset;
//            CGFloat clearOffset = 44;
//
//            if (contentOffset.y >= 0) {
//                self.navBar.alpha = 1;
//            }
//            else {
//                CGFloat alpha = 1 - fabs(contentOffset.y / clearOffset);
//                if (alpha <= 0) {
//                    alpha = 0.0;
//                }
//                else if (alpha > 1.0) {
//                    alpha = 1.0;
//                }
//                self.navBar.alpha = alpha;
//            }
//        }
//
//        // 向下滚动加深navigationBar的颜色
//        if ([self tableViewScrollDownEffect]) {
//
//            CGPoint contentOffset = scrollView.contentOffset;
//            CGFloat clearOffset = 100.0;
//            CGFloat alpha = contentOffset.y / clearOffset;
//
//            if (alpha <= 0) {
//                alpha = 0.0;
//            }
//            else if (alpha > 1.0) {
//                alpha = 1.0;
//            }
//            self.navBar.backgroundView.alpha = alpha;
//        }
    }
}



#pragma mark 结束所有刷新

- (void)endRefreshing {
    [self.loading endLoading];
    [self.refresh endHeaderRefreshing];
    [self.refresh endFooterRefreshing];
}
// --------------------------------------------------------------------------


@end
