//
//  BlockViewController.m
//  NetRequestLib
//
//  Created by Mac on 2018/6/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "BlockViewController.h"
#import "NetRequestLib.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [NetClient initWithBasicURL:@"https://www.sojson.com"];
    NSString *indexURL = @"/open/api/weather/json.shtml?city=北京";
    
    NetRequest *nr = [[NetRequest alloc] initWithRelativeURLString:indexURL
                                                           success:^(id data) {
                                                               NSLog(@"block data %@",data);
                                                           } fail:^(NSError *error) {
                                                               NSLog(@"block error %@",error);
                                                           }];
    [nr loadData];
    
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
