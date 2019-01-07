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
    for (NSDictionary *oneQuery in queriesJson) {
        if([oneQuery[@"queryMethod"] isEqualToString:@"get"]) { // if has getObjectWithId function
            [query getObjectInBackgroundWithId:oneQuery[@"arg1"] block:^(AVObject *object, NSError *error) {
                NSMutableDictionary *serializedJSONDictionary = [object dictionaryForObject];
                NSError *err;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializedJSONDictionary options:0 error:&err];
                NSString *serializedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                result(serializedString);
                return;
            }];
        }
        if([oneQuery[@"queryMethod"] isEqualToString:@"equalTo"]) {
            [query whereKey:oneQuery[@"arg1"] equalTo:oneQuery[@"arg2"]];
        } else if([oneQuery[@"queryMethod"] isEqualToString:@"notEqualTo"]) {
            [query whereKey:oneQuery[@"arg1"] notEqualTo:oneQuery[@"arg2"]];
        } else if([oneQuery[@"queryMethod"] isEqualToString:@"greaterThan"]) {
            [query whereKey:oneQuery[@"arg1"] greaterThan:oneQuery[@"arg2"]];
        } else if([oneQuery[@"queryMethod"] isEqualToString:@"greaterThanOrEqualTo"]) {
            [query whereKey:oneQuery[@"arg1"] greaterThanOrEqualTo:oneQuery[@"arg2"]];
        } else if([oneQuery[@"queryMethod"] isEqualToString:@"lessThan"]) {
            [query whereKey:oneQuery[@"arg1"] lessThan:oneQuery[@"arg2"]];
        } else if([oneQuery[@"queryMethod"] isEqualToString:@"lessThanOrEqualTo"]) {
            [query whereKey:oneQuery[@"arg1"] lessThanOrEqualTo:oneQuery[@"arg2"]];
        }
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error != nil) {
            result([FlutterError errorWithCode:@"leancloud-error"
                                       message:[error localizedDescription]
                                       details:[error localizedFailureReason]]);
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (AVObject *object in objects) {
                NSMutableDictionary *serializedJSONDictionary = [object dictionaryForObject];
                NSError *err;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:serializedJSONDictionary options:0 error:&err];
                NSString *serializedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [array addObject:serializedString];
            }
            NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                     array, @"objects",
                                     nil];
            NSData* jsonData =[NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
            NSString* jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            result(jsonString);
        }
    }];
}

@end
