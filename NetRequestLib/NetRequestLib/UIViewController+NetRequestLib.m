//
//  UIViewController+NetRequestLib.m
//  NetRequestLib
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIViewController+NetRequestLib.h"
#import <objc/runtime.h>
@implementation UIViewController (NetRequestLib)

-(void)setNetRequestEmptyView:(UIView *)netRequestEmptyView{
    objc_setAssociatedObject(self, @"NetRequestLibEmptyView", netRequestEmptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView*)netRequestEmptyView{
    return objc_getAssociatedObject(self, @"NetRequestLibEmptyView");
}


-(void)setNetRequestErrorView:(UIView *)netRequestErrorView{
    objc_setAssociatedObject(self, @"netRequestErrorView", netRequestErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView*)netRequestErrorView{
    return objc_getAssociatedObject(self, @"netRequestErrorView");
}


-(void)addNetRequestEmptyView;{
    self.netRequestEmptyView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIButton *bn = [UIButton buttonWithType:UIButtonTypeCustom];
    bn.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    bn.center = self.netRequestEmptyView.center;
    [bn setTitle:@"没有数据,点击重新加载" forState:UIControlStateNormal];
    [bn setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] forState:UIControlStateNormal];
    [bn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [bn addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    [self.netRequestEmptyView addSubview:bn];
    [self.view addSubview:self.netRequestEmptyView];
}

-(void)removeNetRequestEmptyView;{
    [self.netRequestEmptyView removeFromSuperview];
}

-(void)addNetRequestErrorView;{
    self.netRequestErrorView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIButton *bn = [UIButton buttonWithType:UIButtonTypeCustom];
    bn.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    bn.center = self.netRequestErrorView.center;
    [bn setTitle:@"加载失败,点击重新加载" forState:UIControlStateNormal];
    [bn setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] forState:UIControlStateNormal];
    [bn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [bn addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
    [self.netRequestErrorView addSubview:bn];
    [self.view addSubview:self.netRequestErrorView];
}

-(void)removeNetRequestErrorView;{
    [self.netRequestErrorView removeFromSuperview];
}


-(void)reloadData;{
    NSLog(@"reloadData");
}

-(void)loadData;{
    NSLog(@"loadData");
}

@end
