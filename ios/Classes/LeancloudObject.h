//
//  LeancloudObject.h
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/1/6.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeancloudObject : NSObject

- (void) saveOrCreate:(FlutterMethodCall*)call result:(FlutterResult)result;
- (void) deleteObject:(FlutterMethodCall*)call result:(FlutterResult)result;

@end

NS_ASSUME_NONNULL_END
