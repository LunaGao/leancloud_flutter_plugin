//
//  LeancloudQuery.h
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/1/7.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeancloudQuery : NSObject

- (void) query:(FlutterMethodCall*)call result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
