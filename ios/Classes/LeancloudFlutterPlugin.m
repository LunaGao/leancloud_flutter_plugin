#import "LeancloudFlutterPlugin.h"

#import "LeancloudFunction.h"
#import "LeancloudObject.h"
#import "LeancloudQuery.h"
#import "LeancloudUser.h"

@implementation LeancloudFlutterPlugin

LeancloudFunction *leancloudFunction;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"leancloud_flutter_plugin"
                                     binaryMessenger:[registrar messenger]];
    LeancloudFlutterPlugin* instance = [[LeancloudFlutterPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    leancloudFunction = [[LeancloudFunction alloc] init];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    if ([@"setServer" isEqualToString:call.method]) {
        [leancloudFunction setServer:call result:result];
    } else if ([@"initialize" isEqualToString:call.method]) {
        [leancloudFunction initialize:call result:result];
    } else if ([@"setLogLevel" isEqualToString:call.method]) {
        [leancloudFunction setAllLogsEnabled:call result:result];
    } else if ([@"setRegion" isEqualToString:call.method]) {
        // Auto set region
        result(nil);
    } else if ([@"saveOrCreate" isEqualToString:call.method]) {
        LeancloudObject *leancloudObject = [[LeancloudObject alloc] init];
        [leancloudObject saveOrCreate:call result:result];
    } else if ([@"delete" isEqualToString:call.method]) {
        LeancloudObject *leancloudObject = [[LeancloudObject alloc] init];
        [leancloudObject deleteObject:call result:result];
    } else if ([@"query" isEqualToString:call.method]) {
        LeancloudQuery *leancloudQuery = [[LeancloudQuery alloc] init];
        [leancloudQuery query:call result:result];
    } else if ([@"doCloudQuery" isEqualToString:call.method]) {
        LeancloudQuery *leancloudQuery = [[LeancloudQuery alloc] init];
        [leancloudQuery doCloudQuery:call result:result];
    } else if ([@"signUp" isEqualToString:call.method]) {
        LeancloudUser *leancloudUser = [[LeancloudUser alloc] init];
        [leancloudUser signin:call result:result];
    } else if ([@"login" isEqualToString:call.method]) {
        LeancloudUser *leancloudUser = [[LeancloudUser alloc] init];
        [leancloudUser login:call result:result];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
