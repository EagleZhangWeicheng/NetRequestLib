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
    [NetClient initWithBasicURL:@"https://www.sojson.com"];
    NSString *indexURL = @"/open/api/weather/json.shtml?city=北京";
    
    NetRequest *nr = [[NetRequest alloc] initWithDelegate:self param:nil relativeURLString:indexURL];
//    nr.isUseCashe = true;
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

-(void)initSet{
    [NetRequestCashData shareManager];
    NSString *fileName = @"test/apage/ahhh";
    //    fileName = [self cachedFileNameForKey:fileName];
    //    NSLog(@"filename %@",fileName);
    [[NetRequestCashData shareManager] saveData:@[@"123789",@"124987"] filename:fileName];
    id data = [[NetRequestCashData shareManager] getDataByfilename:fileName];
    NSLog(@"data %@",data);
}

- (nullable NSString *)cachedFileNameForKey:(nullable NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSURL *keyURL = [NSURL URLWithString:key];
    NSString *ext = keyURL ? keyURL.pathExtension : key.pathExtension;
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], ext.length == 0 ? @"" : [NSString stringWithFormat:@".%@", ext]];
    return filename;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
