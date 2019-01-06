//
//  LeancloudFunction.h
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/1/6.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeancloudFunction : NSObject

- (id) init;
- (void) initialize:(FlutterMethodCall*)call result:(FlutterResult)result;
- (void) setAllLogsEnabled:(FlutterMethodCall*)call result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
