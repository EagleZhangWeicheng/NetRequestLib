# NetRequestLib
封装AFNetworking的网络请求  可以缓请求数据

<p><b>1、 集成</b></p>
<p>使用cocoaPos 集成 </p>  
<p>pod 'NetRequestLib',:git => 'https://github.com/EagleZhangWeicheng/NetRequestLib.git'</p>
<p>pod 'NetRequestLib'</p>

<p><b>2、使用</b></p>
<p>① 代理使用</p>
<p>[NetClient initWithBasicURL:@"https://www.example.com"]; //一定需要初始化一次就行</p>
<p>NSString *indexURLStr = @"/api/example";</p>
<p>NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURLStr delegate:self];</p>
<p>[nr loadData];</p>

<p>-(void)willNetRequest:(NetRequest*) netRequest casheData:(id)data; //请求开始</p>
<p>-(void)netRequestDidFinished:(NetRequest*) netRequest responseData:(id)data;  //请求成功走</p>
<p>-(void)netRequestDidFinished:(NetRequest*) netRequest responseData:(id)data; //请求失败</p>

<p>② Block请求使用</p>
<p>[NetClient initWithBasicURL:@"https://www.example.com"];</p>
<p>NSString *indexURL = @"/api/example";</p>

<p>NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURL
success:^(id data) {
NSLog(@"block data %@",data);
} fail:^(NSError *error) {
NSLog(@"block error %@",error);
}];</p>
<p>[nr loadData];</p>


<p>③ 上传图片</p>
[nr postImageKey:@"imageKey" fileName:@"imageFileName" mimeType:@"image/jpg" image:image];


<p>④ 其他使用</p>
<p>a、缓存数据启用</p>
<p>nr.isUseCashe = true;</p>
<p>-(void)willNetRequest:(NetRequest*) netRequest casheData:(id)data; //这里返回缓存数据</p>
<p>b、加载失败view在viewcontroller中提示 也可以使用自定义的加载</p>
<p>nr.isUseError = true;</p>


<p><b>4、注意</b></p>
<p>如果有分页加载数据的情况的话需要处理好分页数据中的缓存</p>


