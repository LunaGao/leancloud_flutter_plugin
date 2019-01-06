//
//  LeancloudFunction.m
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/1/6.
//

#import "LeancloudFunction.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LeancloudArgsConverter.h"

@implementation LeancloudFunction

BOOL isEnable;

- (id) init {
    if (self = [super init]) {
        isEnable = NO;
    }
    return self;
}

- (void) initialize:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *appId = [LeancloudArgsConverter getStringValue:call result:result key:@"appId"];
    NSString *appKey = [LeancloudArgsConverter getStringValue:call result:result key:@"appKey"];
    [AVOSCloud setApplicationId:appId clientKey:appKey];
    // according: https://leancloud.cn/docs/leanstorage_guide-objc.html#hash7247859
    [AVOSCloud setAllLogsEnabled:isEnable];
}

- (void) setAllLogsEnabled:(FlutterMethodCall*)call result:(FlutterResult)result {
    int level_int = [LeancloudArgsConverter getIntValue:call result:result key:@"level"];
    switch (level_int) {
        case 0:
            // already assigned to this value
            break;
        case 1:
            isEnable = YES;
            break;
        case 2:
            isEnable = YES;
            break;
        case 3:
            isEnable = YES;
            break;
        case 4:
            isEnable = YES;
            break;
        case 5:
            isEnable = YES;
            break;
        case 6:
            isEnable = YES;
            break;
        default:
            break;
    }
    // setAllLogsEnabled should be after when setApplicationId:clientKey:
}



@end
