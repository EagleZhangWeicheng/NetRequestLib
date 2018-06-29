//
//  ViewController.m
//  NetRequestLib
//
//  Created by Mac on 2018/6/25.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "NetRequestLib.h"
@interface ViewController ()<NetRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"带缓存请求";
    [self reloadData];
}

-(void)reloadData{
    [NetClient initWithBasicURL:@"https://www.sojson.com"];
    NSString *indexURL = @"/open/api/weather/json.shtml?city=北京";
//    [NetClient initWithBasicURL:@"https://www.baidu.com"];
//    NSString *indexURL = @"";

    
    NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURL delegate:self];
    nr.isUseCashe = true;
    nr.isUseError = true;
    [nr loadData];

}

-(void)willNetRequest:(NetRequest*) netRequest casheData:(id)data;{
    NSLog(@"cashedata %@",data);
}
-(void)netRequestDidFinished:(NetRequest*) netRequest responseData:(id)data;{
    NSLog(@"data %@",data);
}

-(void)netRequestDidFailed:(NetRequest* )netRequest error:(NSError*)error;{
    NSLog(@"error %@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
