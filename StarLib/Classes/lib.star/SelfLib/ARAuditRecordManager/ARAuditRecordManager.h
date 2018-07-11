//
//  ARAuditRecordManager.h
//  Canary
//
//  Created by 星星 on 2018/5/7.
//  Copyright © 2018年 litong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define InAudit 1

@interface ARAuditRecordManager : NSObject

+ (void)event:(UIEvent *)event;

@end
