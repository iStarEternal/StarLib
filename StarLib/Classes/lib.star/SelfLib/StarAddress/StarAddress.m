//
//  StarAddress.m
//  iStarEternal
//
//  Created by 星星 on 16/3/31.
//  Copyright © 2016年 iStarEternal. All rights reserved.
//

#import "StarAddress.h"



@implementation StarAddress

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadAddress];
    }
    return self;
}

- (void)loadAddress {
    NSString *addressBundlePath = [[NSBundle mainBundle] pathForResource:@"StarAddress" ofType:@"bundle"];
    NSString *addressFilePath = [[NSBundle bundleWithPath:addressBundlePath] pathForResource:@"address" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:addressFilePath];
    NSArray *dbProvinces = dict[@"provinces"];
    NSMutableArray *provinces = [NSMutableArray array];
    
    for (NSDictionary *dbProvince in dbProvinces) {
        
        StarAddressProvince *province = [[StarAddressProvince alloc] init];
        province.code = dbProvince[@"code"];
        province.name = dbProvince[@"name"];
        NSMutableArray *citys = [NSMutableArray array];
        
        for (NSDictionary *dbCity in dbProvince[@"citys"]) {
            
            StarAddressCity *city = [[StarAddressCity alloc] init];
            city.province = province;
            city.code = dbCity[@"code"];
            city.name = dbCity[@"name"];
            
            NSMutableArray *areas = [NSMutableArray array];
            for (NSDictionary *dbArea in dbCity[@"areas"]) {
                StarAddressArea *area = [[StarAddressArea alloc] init];
                area.city = city;
                area.code = dbArea[@"code"];
                area.name = dbArea[@"name"];
                [areas addObject:area];
            }
            city.areas = [areas copy];
            
            [citys addObject:city];
        }
        province.citys = [citys copy];
        
        [provinces addObject:province];
    }
    self.provinces = [provinces copy];
}

- (void)setCurrentAddressWithProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex {
    _provinceIndex = provinceIndex;
    _cityIndex = cityIndex;
    _areaIndex = areaIndex;
    
}

- (NSString *)addressDescription {
    NSString * provinceName = self.provinceName;
    NSString * cityName     = self.cityName;
    NSString * areaName      = self.areaName;
    if (provinceName && cityName && areaName) {
        NSMutableString *title = [NSMutableString string];
        [title appendString:provinceName];
        [title appendString:@" "];
        [title appendString:cityName];
        [title appendString:@" "];
        [title appendString:areaName];
        return title;
    }
    return @"";
}


- (NSString *)provinceName {
    StarAddressProvince *province = self.provinces[self.provinceIndex];
    return province.name;
}

- (NSString *)cityName {
    return self.provinces[self.provinceIndex].citys[self.cityIndex].name;
}

- (NSString *)areaName {
    return self.provinces[self.provinceIndex].citys[self.cityIndex].areas[self.areaIndex].name;
}

- (void)setCurrentAddressWithProvinceName:(NSString *)provinceName cityName:(NSString *)cityName areaName:(NSString *)areaName {
    
    NSInteger proviceIndex = -1;
    NSInteger cityIndex = -1;
    NSInteger areaIndex = -1;
    
    for (int i = 0; i < self.provinces.count; i++) {
        StarAddressProvince *province = self.provinces[i];
        if ([province.name isEqualToString:provinceName]) {
            proviceIndex = i;
            break;
        }
    }
    if (proviceIndex < 0) {
        return;
    }
    
    for (int i = 0; i < self.provinces[proviceIndex].citys.count; i++) {
        StarAddressCity *city = self.provinces[proviceIndex].citys[i];
        if ([city.name isEqualToString:cityName]) {
            cityIndex = i;
            break;
        }
    }
    if (cityIndex < 0) {
        return;
    }
    
    for (int i = 0; i < self.provinces[proviceIndex].citys[cityIndex].areas.count; i++) {
        StarAddressArea *area = self.provinces[proviceIndex].citys[cityIndex].areas[i];
        if ([area.name isEqualToString:areaName]) {
            areaIndex = i;
            break;
        }
    }
    
    if (areaIndex < 0) {
        return;
    }
    
    _provinceIndex = proviceIndex;
    _cityIndex = cityIndex;
    _areaIndex = areaIndex;
    
}


- (NSString *)provinceCode {
    return self.provinces[self.provinceIndex].code;
}

- (NSString *)cityCode {
    return self.provinces[self.provinceIndex].citys[self.cityIndex].code;
}

- (NSString *)areaCode {
    return self.provinces[self.provinceIndex].citys[self.cityIndex].areas[self.areaIndex].code;
}

- (void)setCurrentAddressWithProvinceCode:(NSString *)provinceCode cityCode:(NSString *)cityCode areaCode:(NSString *)areaCode {
    
    NSInteger proviceIndex = -1;
    NSInteger cityIndex = -1;
    NSInteger areaIndex = -1;
    
    for (int i = 0; i < self.provinces.count; i++) {
        StarAddressProvince *province = self.provinces[i];
        if ([province.code isEqualToString:provinceCode]) {
            proviceIndex = i;
            break;
        }
    }
    if (proviceIndex < 0) {
        return;
    }
    
    for (int i = 0; i < self.provinces[proviceIndex].citys.count; i++) {
        StarAddressCity *city = self.provinces[proviceIndex].citys[i];
        if ([city.code isEqualToString:cityCode]) {
            cityIndex = i;
            break;
        }
    }
    if (cityIndex < 0) {
        return;
    }
    
    for (int i = 0; i < self.provinces[proviceIndex].citys[cityIndex].areas.count; i++) {
        StarAddressArea *area = self.provinces[proviceIndex].citys[cityIndex].areas[i];
        if ([area.code isEqualToString:areaCode]) {
            areaIndex = i;
            break;
        }
    }
    
    if (areaIndex < 0) {
        return;
    }
    
    _provinceIndex = proviceIndex;
    _cityIndex = cityIndex;
    _areaIndex = areaIndex;
    
}

@end


@implementation StarAddressProvince
@end


@implementation StarAddressCity
@end


@implementation StarAddressArea

@end
