# NetRequestLib
封装AFNetworking的网络请求 带缓存数据

1 集成
使用cocoaPos 集成     pod 'NetRequestLib',:git => 'https://github.com/EagleZhangWeicheng/NetRequestLib.git'

2 使用
代理使用
[NetClient initWithBasicURL:@"https://www.example.com"]; //一定需要初始化一次就行
NSString *indexURLStr = @"/api/example";
NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURLStr delegate:self];
[nr loadData];

-(void)willNetRequest:(NetRequest*) netRequest casheData:(id)data; //请求开始
-(void)netRequestDidFinished:(NetRequest*) netRequest responseData:(id)data;  //请求成功走
-(void)netRequestDidFinished:(NetRequest*) netRequest responseData:(id)data; //请求失败

Block请求使用
[NetClient initWithBasicURL:@"https://www.example.com"];
NSString *indexURL = @"/api/example";

NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURL
success:^(id data) {
NSLog(@"block data %@",data);
} fail:^(NSError *error) {
NSLog(@"block error %@",error);
}];
[nr loadData];


缓存数据启用
nr.isUseCashe = true;
-(void)willNetRequest:(NetRequest*) netRequest casheData:(id)data; //这里返回缓存数据



如果有分页加载数据的情况的话需要处理好分页数据中的缓存


