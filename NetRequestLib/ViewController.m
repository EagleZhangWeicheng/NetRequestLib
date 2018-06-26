//
//  ViewController.m
//  NetRequestLib
//
//  Created by Mac on 2018/6/25.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "NetRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "NetRequestCashData.h"
@interface ViewController ()<NetRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"带缓存请求";
    [NetClient initWithBasicURL:@"https://www.sojson.com"];
    NSString *indexURL = @"/open/api/weather/json.shtml?city=北京";
    
    NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURL delegate:self];
    nr.isUseCashe = true;
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


@end