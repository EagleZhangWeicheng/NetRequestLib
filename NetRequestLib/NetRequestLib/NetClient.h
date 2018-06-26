//
//  NetClient.h
//
//
//  Created by zhangweicheng on 2017/5/3.
//  Copyright © 2017年 . All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetClient : AFHTTPSessionManager
+(NetClient*)sharedManager;
+(void)initWithBasicURL:(NSString*)basicURL; //必须初始化一个

+(void)initWithBasicURL:(NSString*)basicURL
               pageSize:(NSInteger)pageSize
           pageKeywords:(nullable NSString*)pageKeywords
       pageSizeKeywords:(nullable NSString*)pageSizeKeywords
      tokenHeadKeywords:(nullable NSString*)tokenHeadKeywords
  deiviceClientKeywords:(nullable NSString*)deiviceClientKeywords;


@property(nonatomic,assign)NSInteger pageSize; //页面大小 默认为10
@property(nonatomic,copy)NSString *pageKeywords; //页关键词 默认为page
@property(nonatomic,copy)NSString *pageSizeKeywords; //页面大小关键词 默认为pagesize
@property(nonatomic,copy)NSString *tokenHeadKeywords; //token头部关键词 默认为 token
@property(nonatomic,copy)NSString *deiviceClientKeywords; //设备头部关键词 默认为 DeiviceClient


@end
