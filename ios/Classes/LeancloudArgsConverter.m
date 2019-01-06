//
//  LeancloudArgsConverter.m
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/1/6.
//

#import "LeancloudArgsConverter.h"

@implementation LeancloudArgsConverter

+ (NSString*) getStringValue:(FlutterMethodCall*)call result:(FlutterResult)result key:(NSString*)key {
    id arg = call.arguments[key];
    if (arg == nil) {
        result([FlutterError errorWithCode:@"missing-arg"
                                   message:@"Arg '%@' can't be null, set empty value. PLEASE FIX IT!"
                                   details:nil]);
    } else {
        if ([arg isKindOfClass:[NSString class]]) {
            return [NSString stringWithFormat:@"%@", arg];
        } else {
            result([FlutterError errorWithCode:@"arg-type-error"
                                       message:@"Arg '%@' should be String. PLEASE FIX IT!"
                                       details:nil]);
        }
    }
    return @"";
}

+ (int) getIntValue:(FlutterMethodCall*)call result:(FlutterResult)result key:(NSString*)key {
    id arg = call.arguments[key];
    if (arg == nil) {
        result([FlutterError errorWithCode:@"missing-arg"
                                   message:@"Arg '%@' can't be null, set empty value. PLEASE FIX IT!"
                                   details:nil]);
    } else {
        if ([arg isKindOfClass:[NSNumber class]]) {
            return [arg intValue];
        } else {
            result([FlutterError errorWithCode:@"arg-type-error"
                                       message:@"Arg '%@' should be int. PLEASE FIX IT!"
                                       details:nil]);
        }
    }
    return 0;
}

@end
