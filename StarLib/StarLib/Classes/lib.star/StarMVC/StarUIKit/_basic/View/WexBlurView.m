
#import "WexBlurView.h"

@interface WexBlurView ()

@end

@implementation WexBlurView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self wex_loadViews];
        [self wex_layoutConstraints];
    }
    return self;
}




#pragma mark - Subview处理函数

- (void)wex_loadViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)wex_layoutConstraints {
    
}
@end
