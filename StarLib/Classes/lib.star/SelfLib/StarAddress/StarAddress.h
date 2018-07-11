//
//  StarAddress.h
//  iStarEternal
//
//  Created by 星星 on 16/3/31.
//  Copyright © 2016年 iStarEternal. All rights reserved.
//

#import <Foundation/Foundation.h>


@class StarAddressProvince;
@class StarAddressCity;
@class StarAddressArea;


// 地址
@interface StarAddress : NSObject

@property (nonatomic, strong) NSArray<StarAddressProvince *> *provinces;

@property (nonatomic, assign, readonly) NSInteger provinceIndex;
@property (nonatomic, assign, readonly) NSInteger cityIndex;
@property (nonatomic, assign, readonly) NSInteger areaIndex;

@property (nonatomic, copy) NSString *addressDescription;

- (void)setCurrentAddressWithProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex;


@property (nonatomic, copy, readonly) NSString *provinceName;
@property (nonatomic, copy, readonly) NSString *cityName;
@property (nonatomic, copy, readonly) NSString *areaName;

- (void)setCurrentAddressWithProvinceName:(NSString *)provinceName cityName:(NSString *)cityName areaName:(NSString *)areaName;


@property (nonatomic, copy, readonly) NSString *provinceCode;
@property (nonatomic, copy, readonly) NSString *cityCode;
@property (nonatomic, copy, readonly) NSString *areaCode;

- (void)setCurrentAddressWithProvinceCode:(NSString *)provinceCode cityCode:(NSString *)cityCode areaCode:(NSString *)areaCode;

@end


// 省
@interface StarAddressProvince : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSArray<StarAddressCity *> *citys;
@end


// 市
@interface StarAddressCity : NSObject

@property (nonatomic, weak) StarAddressProvince *province;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSArray<StarAddressArea *> *areas; // 区
@end

// 区
@interface StarAddressArea : NSObject

@property (nonatomic, weak) StarAddressCity *city;
@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSString * name;
@end
