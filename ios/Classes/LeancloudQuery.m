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

const NSString *QUERYMETHOD = @"queryMethod";
const NSString *ARG1 = @"arg1";
const NSString *ARG2 = @"arg2";

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
        if([oneQuery[QUERYMETHOD] isEqualToString:@"equalTo"]) {
            [query whereKey:oneQuery[ARG1] equalTo:oneQuery[ARG2]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"notEqualTo"]) {
            [query whereKey:oneQuery[ARG1] notEqualTo:oneQuery[ARG2]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"greaterThan"]) {
            [query whereKey:oneQuery[ARG1] greaterThan:oneQuery[ARG2]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"greaterThanOrEqualTo"]) {
            [query whereKey:oneQuery[ARG1] greaterThanOrEqualTo:oneQuery[ARG2]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"lessThan"]) {
            [query whereKey:oneQuery[ARG1] lessThan:oneQuery[ARG2]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"lessThanOrEqualTo"]) {
            [query whereKey:oneQuery[ARG1] lessThanOrEqualTo:oneQuery[ARG2]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"orderByAscending"]) {
            [query orderByAscending:oneQuery[ARG1]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"orderByDescending"]) {
            [query orderByDescending:oneQuery[ARG1]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"addAscendingOrder"]) {
            [query addDescendingOrder:oneQuery[ARG1]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"addDescendingOrder"]) {
            [query addDescendingOrder:oneQuery[ARG1]];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"limit"]) {
            query.limit = [oneQuery[ARG1] intValue];
        } else if([oneQuery[QUERYMETHOD] isEqualToString:@"skip"]) {
            query.skip = [oneQuery[ARG1] intValue];
        } else {
            result([FlutterError errorWithCode:@"params-error"
                                       message:@"no such query queryMethod name, please check again"
                                       details:[NSString stringWithFormat:@"no such query queryMethod name, %@", oneQuery[QUERYMETHOD]]]);
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
