//
//  NetRequestCashData.h
//  NetRequestLib
//
//  Created by Mac on 2018/6/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestCashData : NSObject
-(void)saveData:(id)data page:(NSInteger)page urlString:(NSString*)urlString;
-(id)getDataByUrlString:(NSString*)urlString;
+(NetRequestCashData*)shareManager;
@end
