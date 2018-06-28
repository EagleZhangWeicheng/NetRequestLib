//
//  NetRequst.h
//
//
//  Created by zhangweicheng on 2017/5/3.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetRequestCashData.h"
#import "NetClient.h"
#import "UIViewController+NetRequestLib.h"
#import <AFNetworking/AFNetworking.h>

@class NetRequest;

@protocol NetRequestDelegate <NSObject>
@optional
-(void)willNetRequest:(NetRequest*) netRequest casheData:(id)data;
-(void)netRequestDidFinished:(NetRequest*) netRequest responseData:(id)data;
-(void)netRequestDidFailed:(NetRequest* )netRequest error:(NSError*)error;
@end

typedef void (^NetRequestSuccess)(id data);
typedef void (^NetRequestFail)(NSError * error);


@interface NetRequest : NSObject

@property(nonatomic,weak) id<NetRequestDelegate> delegate;
@property(nonatomic,strong) NSString * relativeURLString; //相对地址
@property(nonatomic,assign)NSInteger currentPage; //当前页面
@property(nonatomic,assign)NSInteger tag; //请求标识
@property(nonatomic,strong)id param; //传的参数
@property(nonatomic,copy) NetRequestSuccess success;
@property(nonatomic,copy) NetRequestFail fail;

@property(nonatomic)BOOL isUseCashe; //是否使用缓存 默认不使用
@property(nonatomic)BOOL isUseError; //是否使用异常view 默认不使用


- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                 delegate:(id)delegate;

- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                 delegate:(id)delegate
                                    param:(id)param;

- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                  success:(NetRequestSuccess)success
                                     fail:(NetRequestFail)fail;

- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                  success:(NetRequestSuccess)success
                                     fail:(NetRequestFail)fail
                                    param:(id)param;

#pragma load data
-(void)loadData; //加载数据
-(void)loadDataWithPage:(NSInteger)page; //获取page页的数据
-(void)reloadData; //重新加载数据
-(void)loadNextPage; //加载下一页数据
-(void)loadPrePage; //加载前一页数据

#pragma post data
-(void)postData; //提交数据
-(void)postDataWithPage:(NSInteger)page; //获取page页的数据
-(void)reloadPostData; //重新提交数据
-(void)postNextPage; //加载下一页数据
-(void)postPrePage; //加载前一页数据

#pragma del data 删除数据
-(void)delData;

#pragma mark patch data 修改数据
-(void)patchData;

#pragma mark post image 上传图片
-(void)postImageKey:(NSString*)imagekey //@"users[avater]"
           fileName:(NSString*)fileName // @"1111.jpg"
           mimeType:(NSString*)mimeType //@"image/jpg"];
             image :(UIImage*)image;
@end
