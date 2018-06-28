# NetRequestLib
封装AFNetworking的网络请求 带缓存数据

使用cocoaPos 集成     pod 'NetRequestLib',:git => 'https://github.com/EagleZhangWeicheng/NetRequestLib.git'

1 缓存数据使用
[NetClient initWithBasicURL:@"https://www.sojson.com"]; //一定需要初始化一次就行
 NSString *indexURLStr = @"/open/api/weather/json.shtml?city=北京";
NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURLStr delegate:self];
nr.isUseCashe = true;

-(void)willNetRequest:(NetRequest*) netRequest casheData:(id)data;
//这里返回缓存数据
-(void)netRequestDidFinished:(NetRequest*) netRequest responseData:(id)data; 
//正常情况返回数据之后要清除缓存数据


2 block使用
[NetClient initWithBasicURL:@"https://www.sojson.com"];
NSString *indexURL = @"/open/api/weather/json.shtml?city=北京";

NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURL
success:^(id data) {
NSLog(@"block data %@",data);
} fail:^(NSError *error) {
NSLog(@"block error %@",error);
}];
[nr loadData];


如果有分页加载数据的情况的话需要处理好分页数据中的缓存


