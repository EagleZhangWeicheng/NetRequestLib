//
//  UIViewController+NetRequestLib.h
//  NetRequestLib
//
//  Created by Mac on 2018/6/27.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NetRequestLib)
@property(nonatomic,strong)UIView *netRequestEmptyView; //空白view
@property(nonatomic,strong)UIView *netRequestErrorView; //异常view

-(void)addNetRequestEmptyView;
-(void)removeNetRequestEmptyView;

-(void)addNetRequestErrorView;
-(void)removeNetRequestErrorView;

-(void)reloadData;
-(void)loadData;

@end
