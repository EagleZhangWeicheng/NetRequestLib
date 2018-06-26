//
//  TestViewController.m
//  NetRequestLib
//
//  Created by Mac on 2018/6/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "TestViewController.h"
#import "NetRequestLib.h"
@interface TestViewController ()<NetRequestDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"不带缓存请求";
    // Do any additional setup after loading the view.
    [NetClient initWithBasicURL:@"https://www.sojson.com"];
    NSString *indexURL = @"/open/api/weather/json.shtml?city=北京";
    
    NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURL delegate:self];
    [nr loadData];
}

-(void)willNetRequest:(NetRequest*) netRequest casheData:(id)data;{
    NSLog(@"cashedata %@",data);
}
-(void)netRequestDidFinished:(NetRequest*) netRequest getData:(id)data;{
    NSLog(@"data %@",data);
}

-(void)netRequestDidFailed:(NetRequest* )netRequest getError:(NSError*)error;{
    NSLog(@"error %@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
