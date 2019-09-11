//
//  LeancloudUser.m
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/6/20.
//

#import "LeancloudUser.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LeancloudArgsConverter.h"

@implementation LeancloudUser

- (void) signin:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *avQueryJson = [LeancloudArgsConverter getAVUserJsonObject:call result:result];
    NSString *fieldsString = avQueryJson[@"fields"];
    NSDictionary *fieldsJson = [LeancloudArgsConverter stringToJson:fieldsString];
    AVUser *user = [AVUser user];
    user.username = fieldsJson[@"username"];
    user.password = fieldsJson[@"password"];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSMutableDictionary *serializedJSONDictionary = [user dictionaryForObject];
            NSError *err;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializedJSONDictionary options:0 error:&err];
            NSString *serializedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSString *jsonString = serializedString;
            result(jsonString);
        } else {
            NSNumber *errorCode = [NSNumber numberWithInteger:[error code]];
            result([FlutterError errorWithCode:@"leancloud-error"
                                       message:[error localizedFailureReason]
                                       details:errorCode]);
        }
    }];
}

- (void) login:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *avQueryJson = [LeancloudArgsConverter getAVUserJsonObject:call result:result];
    NSString *fieldsString = avQueryJson[@"fields"];
    NSDictionary *fieldsJson = [LeancloudArgsConverter stringToJson:fieldsString];
    [AVUser logInWithUsernameInBackground:fieldsJson[@"username"] password:fieldsJson[@"password"] block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSMutableDictionary *serializedJSONDictionary = [user dictionaryForObject];
            NSError *err;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializedJSONDictionary options:0 error:&err];
            NSString *serializedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSString *jsonString = serializedString;
            result(jsonString);
        } else {
            NSNumber *errorCode = [NSNumber numberWithInteger:[error code]];
            result([FlutterError errorWithCode:@"leancloud-error"
                                       message:[error localizedFailureReason]
                                       details:errorCode]);
        }
    }];
}

@end
