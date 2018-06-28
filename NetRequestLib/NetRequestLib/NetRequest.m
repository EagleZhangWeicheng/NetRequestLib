//
//  NetRequst.m
//
//
//  Created by zhangweicheng on 2017/5/3.
//  Copyright © 2017年 . All rights reserved.
//

#import "NetRequest.h"


@implementation NetRequest
#pragma init NetRequest
- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                 delegate:(id)delegate;{
    return [self initWithRelativeURLString:relativeURLString delegate:delegate param:nil];
}

- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                 delegate:(id)delegate
                                    param:(id)param;{
    self = [super init];
    if (self) {
        [self initSetParam];
        self.delegate = delegate;
        self.relativeURLString = relativeURLString;
        self.param = param;
    }
    return self;
}

- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                  success:(NetRequestSuccess)success
                                     fail:(NetRequestFail)fail{
    return [self initWithRelativeURLString:relativeURLString success:success fail:fail param:nil];
}

- (instancetype)initWithRelativeURLString:(NSString*)relativeURLString
                                  success:(NetRequestSuccess)success
                                     fail:(NetRequestFail)fail
                                    param:(id)param;{
    self = [super init];
    if (self) {
        [self initSetParam];
        self.relativeURLString = relativeURLString;
        self.success = success;
        self.fail = fail;
        self.param = param;
    }
    return self;
}

#pragma mark load data
-(void)loadData{//加载数据
    self.currentPage = 1;
    [self loadDataWithPage:self.currentPage];
}

-(void)loadDataWithPage:(NSInteger)page{ //获取page页的数据
    self.currentPage = page;
    [self setWillNetRequstWithInUseCashe:true];

    NSString *tempURLString = [self returnRelativeURLStringWithPage:page];
    id  iddelgegate = self.delegate;
    [[NetClient sharedManager] GET:tempURLString
                        parameters:self.param
                          progress:nil
                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                               if (self.isUseError) {
                                   [self removeErrorView];
                               }
                               
                               [self setNetRequstFinishedWithDelegate:iddelgegate data:responseObject];
                               
                               if (self.isUseCashe) {
                                   [[NetRequestCashData shareManager] saveData:responseObject page:self.currentPage urlString:tempURLString];
                               }
                        }
                           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                               [self setNetRequstFailedWithWithDelegate:iddelgegate error:error];
                               if (self.isUseError) {
                                   [self addErrorView];
                               }
                        }];
}

-(void)reloadData{ //重新加载数据
    [self loadDataWithPage:1];
}

-(void)loadNextPage{//加载下一页数据
    self.currentPage += 1;
    [self loadDataWithPage:self.currentPage];
}

-(void)loadPrePage{//加载前一页数据
    self.currentPage -= 1;
    if (self.currentPage <= 0) {
        self.currentPage = 1;
    }
    [self loadDataWithPage:self.currentPage];
}

#pragma post data
-(void)postData{ //提交数据
    self.currentPage = 1;
    [self postDataWithPage:self.currentPage];
}

-(void)postDataWithPage:(NSInteger)page{ //获取page页的数据
    self.currentPage = page;
    [self setWillNetRequstWithInUseCashe:true];
    NSString *tempURLString = [self returnRelativeURLStringWithPage:page];
    id  iddelgegate = self.delegate;
    
    [[NetClient sharedManager] POST:tempURLString
                         parameters:self.param
                           progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                if (self.isUseError) { //移除错误提示
                                    [self removeErrorView];
                                }
                                [self setNetRequstFinishedWithDelegate:iddelgegate data:responseObject];
                                if (self.isUseCashe) {
                                    [[NetRequestCashData shareManager] saveData:responseObject page:self.currentPage urlString:tempURLString];
                                }
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                [self setNetRequstFailedWithWithDelegate:iddelgegate error:error];
                                if (self.isUseError) { //加错误提示
                                    [self addErrorView];
                                }
                            }];
}

-(void)reloadPostData{ //重新提交数据
    self.currentPage = 1;
    [self postDataWithPage:self.currentPage];
}

-(void)postNextPage{ //加载下一页数据
    self.currentPage += 1;
    [self postDataWithPage:self.currentPage];
}

-(void)postPrePage{ //加载前一页数据
    self.currentPage -= 1;
    if (self.currentPage <= 0) {
        self.currentPage = 1;
    }
    [self postDataWithPage:self.currentPage];
}

-(void)initSetParam{
    _currentPage = 1;
}

#pragma mark 设置头部参数
-(void)setHeadParam{
    [self setToken];
    [self setDevice];
}

#pragma mark 设置token
-(void)setToken{
    NetClient *nc = [NetClient sharedManager];
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:nc.tokenHeadKeywords];
    if (token != nil) {
        NetClient * client = [NetClient sharedManager];
        AFHTTPRequestSerializer *tempRequestSerializer = client.requestSerializer;
        [tempRequestSerializer setValue:token forHTTPHeaderField:client.tokenHeadKeywords];
    }
}

#pragma mark 设置设备参数
-(void)setDevice{
    NSString *deviceString = @"IOS";
    if (UIUserInterfaceIdiomPad == [UIDevice currentDevice].userInterfaceIdiom) {
        deviceString = @"iPad";
    }
    else if (UIUserInterfaceIdiomPhone == [UIDevice currentDevice].userInterfaceIdiom){
        deviceString = @"iPhone";
    }
    NetClient * client = [NetClient sharedManager];
    AFHTTPRequestSerializer *tempRequestSerializer = client.requestSerializer;
    [tempRequestSerializer setValue:deviceString forHTTPHeaderField:client.deiviceClientKeywords];
}

#pragma del data 删除数据
-(void)delData;
{
    [self setWillNetRequstWithInUseCashe:false];
    
    NSString *tempURLString = [self returnRelativeURLStringWithPage:0];
    id idDelegate = self.delegate;
    [[NetClient sharedManager] DELETE:tempURLString
                           parameters:self.param
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  [self setNetRequstFinishedWithDelegate:idDelegate data:responseObject];
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  [self setNetRequstFailedWithWithDelegate:idDelegate error:error];
                              }];
}

#pragma mark patch data 修改数据
-(void)patchData;{
    [self setWillNetRequstWithInUseCashe:false];
    
    NSString *tempURLString = [self returnRelativeURLStringWithPage:0];
    id idDelegate = self.delegate;
    [[NetClient sharedManager] PATCH:tempURLString
                           parameters:self.param
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  [self setNetRequstFinishedWithDelegate:idDelegate data:responseObject];
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  [self setNetRequstFailedWithWithDelegate:idDelegate error:error];
                              }];
}

#pragma mark post image 上传图片
-(void)postImageKey:(NSString*)imagekey //@"users[avater]"
           fileName:(NSString*)fileName // @"1111.jpg"
           mimeType:(NSString*)mimeType //@"image/jpg"];
             image :(UIImage*)image;{
    [self setWillNetRequstWithInUseCashe:false];

    id idDelegate = self.delegate;
    NSString *tempURLString = [self returnRelativeURLStringWithPage:0];
    [[NetClient sharedManager] POST:tempURLString
                         parameters:self.param
          constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
              NSData *data  = UIImageJPEGRepresentation(image, 0.7);
              [formData appendPartWithFileData:data
                                          name:imagekey
                                      fileName:fileName
                                      mimeType:mimeType];
          } progress:^(NSProgress * _Nonnull uploadProgress) {
              
          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              [self setNetRequstFinishedWithDelegate:idDelegate data:responseObject];
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [self setNetRequstFailedWithWithDelegate:idDelegate error:error];
          }];
}

#pragma mark 返回相对路径
-(NSString*)returnRelativeURLStringWithPage:(NSInteger)page{
    if (page == 0) {
        return [_relativeURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSString *tempURLString = @"";
    NetClient *nc = [NetClient sharedManager];
    if ([_relativeURLString containsString:@"?"]) {
        tempURLString = [NSString stringWithFormat:@"%@&%@=%ld&%@=%ld",_relativeURLString,
                         nc.pageKeywords,page,nc.pageSizeKeywords,nc.pageSize];
    }
    else{
        tempURLString = [NSString stringWithFormat:@"%@?%@=%ld&%@=%ld",_relativeURLString,
                         nc.pageKeywords,page,nc.pageSizeKeywords,nc.pageSize];
    }
    tempURLString = [tempURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return tempURLString;
}

#pragma mark 开始请求设置
-(void)setWillNetRequstWithInUseCashe:(BOOL)inUseCashe //inUseCashe 里面是否使用缓存 get post 为ture de patch false
{
    [self setHeadParam];
    //开始加载数据
    if([_delegate respondsToSelector:@selector(willNetRequest:casheData:)]){
        id data = nil;
        if (self.isUseCashe && inUseCashe) {
            data = [[NetRequestCashData shareManager] getDataByUrlString:self.relativeURLString];
        }
        [_delegate willNetRequest:self casheData:data];
    }
    
    if (self.success != nil && self.isUseCashe  && inUseCashe) {
        id data = [[NetRequestCashData shareManager] getDataByUrlString:self.relativeURLString];
        self.success(data);
    }
}

#pragma mark 请求成功
-(void)setNetRequstFinishedWithDelegate:(id)iddelgegate data:(id)responseObject{
    if ([iddelgegate respondsToSelector:@selector(netRequestDidFinished:responseData:)]) {
        [iddelgegate netRequestDidFinished:self responseData:responseObject];
    }
    
    if (self.success != nil) {
        self.success(responseObject);
    }
}


#pragma mark 请求失败
-(void)setNetRequstFailedWithWithDelegate:(id)iddelgegate error:(NSError*)error{
    if ([iddelgegate respondsToSelector:@selector(netRequestDidFailed:error:)]) {
        [iddelgegate netRequestDidFailed:self error:error];
    }
    
    if (self.fail != nil) {
        self.fail(error);
    }
}


-(void)addErrorView{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController*)self.delegate;
        [vc addNetRequestErrorView];
    }
}

-(void)removeErrorView{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController*)self.delegate;
        [vc removeNetRequestErrorView];
    }
}
@end
