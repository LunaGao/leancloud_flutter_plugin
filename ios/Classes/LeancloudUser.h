//
//  LeancloudUser.h
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/6/20.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeancloudUser : NSObject

- (void) signin:(FlutterMethodCall*)call result:(FlutterResult)result;
- (void) login:(FlutterMethodCall*)call result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
