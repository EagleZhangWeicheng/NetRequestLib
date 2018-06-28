//
//  NetRequestCashData.m
//  NetRequestLib
//
//  Created by Mac on 2018/6/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "NetRequestCashData.h"
#import <CommonCrypto/CommonDigest.h>

@interface NetRequestCashData()
@property (strong, nonatomic, nonnull) NSFileManager *fileManager;
@property (strong, nonatomic, nonnull) NSString *diskCachePath;
@property (strong, nonatomic, nullable) dispatch_queue_t ioQueue;


@end

@implementation NetRequestCashData
static NetRequestCashData *cashData = nil;
+ (NetRequestCashData *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cashData = [[NetRequestCashData alloc] init];
    });
    
    return cashData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *fullPath = @"com.ealge.netrequestcashe";
        _diskCachePath = [self makeDiskCachePath:fullPath];
        NSLog(@"_diskCachePath %@",_diskCachePath);
        _ioQueue = dispatch_queue_create("com.ealge.netrequestcashe", DISPATCH_QUEUE_SERIAL);
        dispatch_async(_ioQueue, ^{
            self.fileManager = [[NSFileManager alloc] init];
            if (![self.fileManager isExecutableFileAtPath:self.diskCachePath]) {
                [self.fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:true attributes:nil error:nil];
            }
        });
        
    }
    return self;
}

- (nullable NSString *)makeDiskCachePath:(nonnull NSString*)fullNamespace {
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}


-(void)saveData:(id)data page:(NSInteger)page urlString:(NSString*)urlString;{
    if (page != 1) {
        return;
    }
    NSString *filePath = [self getFullFilePathByUrlString:urlString];
    dispatch_async(_ioQueue, ^{
        @try{
            BOOL saveStatus = [NSKeyedArchiver archiveRootObject:data toFile:filePath];
            NSLog(@"saveStauts %d",saveStatus);
        }
        @catch (NSException *e){
            NSLog(@"e %@",e);
            return ;
        }
    });
}

-(id)getDataByUrlString:(NSString*)urlString{
    NSString *filePath = [self getFullFilePathByUrlString:urlString];
    return   [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

-(NSString*)getFullFilePathByUrlString:(NSString*)urlString{
    NSString *fileName = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    fileName = [fileName stringByReplacingOccurrencesOfString:@"." withString:@""];
    fileName = [self cachedFileNameForKey:fileName];
    NSString *fullFilePath = [self getFullPathWithFileName:fileName];
    return fullFilePath;
}

- (nullable NSString *)cachedFileNameForKey:(nullable NSString *)key { //md5加密路径名称
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


-(NSString*)getFullPathWithFileName:(NSString*)fileName{
    return [self.diskCachePath stringByAppendingPathComponent:fileName];
}




@end
