//
//  LeancloudArgsConverter.h
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/1/6.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeancloudArgsConverter : NSObject

+ (NSString*) getStringValue:(FlutterMethodCall*)call result:(FlutterResult)result key:(NSString*)key;
+ (int) getIntValue:(FlutterMethodCall*)call result:(FlutterResult)result key:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
