//
//  LeancloudQuery.m
//  leancloud_flutter_plugin
//
//  Created by Luna on 2019/1/7.
//

#import "LeancloudQuery.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LeancloudArgsConverter.h"

@implementation LeancloudQuery

- (void) query:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *avQueryJson = [LeancloudArgsConverter getAVQueryJsonObject:call result:result];
    NSString *className = avQueryJson[@"className"];
    NSString *queriesString = avQueryJson[@"queries"];
    NSDictionary *queriesJson = [LeancloudArgsConverter stringToJson:queriesString];
    AVQuery *query = [AVQuery queryWithClassName:className];
    if (queriesJson.count == 1 && [queriesJson.allKeys containsObject:@"get"]) {
        [query getObjectInBackgroundWithId:queriesJson[@"get"] block:^(AVObject *object, NSError *error) {
            NSMutableDictionary *serializedJSONDictionary = [object dictionaryForObject];
            NSError *err;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializedJSONDictionary options:0 error:&err];
            NSString *serializedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            result(serializedString);
        }];
    }
}

@end
