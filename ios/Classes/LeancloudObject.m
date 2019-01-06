//
//  LeancloudObject.m
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/1/6.
//

#import "LeancloudObject.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LeancloudArgsConverter.h"

@implementation LeancloudObject

- (void) saveOrCreate:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *avObject_string = [LeancloudArgsConverter getStringValue:call result:result key:@"avObject"];
    AVObject *avObject = [self convertStringToAVObject:avObject_string];
    if (avObject == nil) {
        result([FlutterError errorWithCode:@"arg-format-error"
                                   message:@"Arg avObject should be JSON String. PLEASE FIX IT!"
                                   details:nil]);
    }
    [avObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSMutableDictionary *serializedJSONDictionary = [avObject dictionaryForObject];
            NSError *err;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializedJSONDictionary options:0 error:&err];
            NSString *serializedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            result(serializedString);
        } else {
            result([FlutterError errorWithCode:@"leancloud-error"
                                       message:[error localizedDescription]
                                       details:[error localizedFailureReason]]);
        }
    }];
}

- (void) deleteObject:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *avObject_string = [LeancloudArgsConverter getStringValue:call result:result key:@"avObject"];
    AVObject *avObject = [self convertStringToAVObject:avObject_string];
    if (avObject == nil) {
        result([FlutterError errorWithCode:@"arg-format-error"
                                   message:@"Arg avObject should be JSON String. PLEASE FIX IT!"
                                   details:nil]);
    }
    [avObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            result(@YES);
        } else {
            result([FlutterError errorWithCode:@"leancloud-error"
                                       message:[error localizedDescription]
                                       details:[error localizedFailureReason]]);
        }
    }];
}

- (AVObject*) convertStringToAVObject:(NSString *)avObjectString {
    NSDictionary *avObjectJson = [self stringToJson:avObjectString];
    if(avObjectJson == nil)
    {
        return nil;
    }
    NSString *className = avObjectJson[@"className"];
    NSDictionary *fieldsJson = [self stringToJson:avObjectJson[@"fields"]];
    if(fieldsJson == nil)
    {
        return nil;
    }
    AVObject *avObject;
    if ([fieldsJson.allKeys containsObject:@"objectId"]) {
        avObject = [AVObject objectWithObjectId:fieldsJson[@"objectId"]];
    } else {
        avObject = [AVObject objectWithClassName:className];
    }
    
    for (NSString *key in [fieldsJson allKeys]) {
        //TODO if those value is Date or byte[] type?
        //TODO more data type? e.g. AVGeoPoint？
        if ([key isEqualToString:@"createdAt"]) continue;
        if ([key isEqualToString:@"updatedAt"]) continue;
        if ([key isEqualToString:@"objectId"]) continue;
        else [avObject setObject:fieldsJson[key] forKey:key];
    }
    return avObject;
}

- (NSDictionary*) stringToJson:(NSString*) jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&err];
    if(err)
    {
        NSLog(@"Json ERROR: %@",err);
        return nil;
    }
    return jsonObject;
}

@end
