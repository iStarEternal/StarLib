//
//  StarBannerPlayer.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/2.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarBannerPlayer;

@protocol StarBannerPlayerDelegate <NSObject>

@optional
-(void)bannnerPlayer:(StarBannerPlayer *)bannerPlayer didSelectIndex:(NSInteger)index;

@end

@interface StarBannerPlayer : UIView

@property (nonatomic, assign) CGFloat timeInterval;
@property (strong, nonatomic) NSArray<UIImage *> *sourceArray;
@property (strong, nonatomic) NSArray<NSString *> *URLStrings;
@property (strong, nonatomic) id<StarBannerPlayerDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame sourceArray:(NSArray<UIImage *> *)sourceArray scrollInterval:(NSTimeInterval)scrollInterval;

//设置图片
-(void)loadImages:(NSArray *)sourceArray;

@end