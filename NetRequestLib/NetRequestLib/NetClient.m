//
//  NetClient.m
//
//
//  Created by zhangweicheng on 2017/5/3.
//  Copyright © 2017年 . All rights reserved.
//

#import "NetClient.h"

@implementation NetClient
static NetClient * client = nil;

+(NetClient*)sharedManager;{
    return client;
}

+(void)initWithBasicURL:(NSString*)basicURL;{
    [NetClient initWithBasicURL:basicURL
                       pageSize:0
                   pageKeywords:nil
               pageSizeKeywords:nil
              tokenHeadKeywords:nil
          deiviceClientKeywords:nil];
}

+(void)initWithBasicURL:(NSString*)basicURL
               pageSize:(NSInteger)pageSize
           pageKeywords:(nullable NSString* )pageKeywords
       pageSizeKeywords:(nullable NSString* )pageSizeKeywords
      tokenHeadKeywords:(nullable NSString* )tokenHeadKeywords
  deiviceClientKeywords:(nullable NSString*)deiviceClientKeywords;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[NetClient alloc] initWithBaseURL:[NSURL URLWithString:basicURL]];
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",@"application/rss+xml",nil];
        client.pageSize = pageSize <= 0? 10:pageSize;
        client.pageKeywords = pageKeywords == nil || [pageKeywords isEqualToString:@""]?@"page":pageKeywords;
        client.pageSizeKeywords = pageSizeKeywords == nil || [pageSizeKeywords isEqualToString:@""]?@"pageSize":pageSizeKeywords;
        client.tokenHeadKeywords = tokenHeadKeywords == nil || [tokenHeadKeywords isEqualToString:@""]?@"token":tokenHeadKeywords;
        client.deiviceClientKeywords = deiviceClientKeywords == nil || [deiviceClientKeywords isEqualToString:@""] ?@"DeiviceClient":deiviceClientKeywords;
    });
}




@end
