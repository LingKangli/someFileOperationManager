//
//  FileOperationManager.m
//  DataDemo
//
//  Created by LingKangLi on 16/1/8.
//  Copyright (c) 2016年 Kaly.Co.,Ltd. All rights reserved.
//

#import "FileOperationManager.h"

@implementation FileOperationManager


#pragma mark ============= 文件 目录 读取 begin ==========================
+(NSString*)getDocuments{//1.获取Documents目录路径的方法
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
+(NSString*)getCaches{//2.获取Caches目录路径的方法
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString*)getLibrary{//获取Library目录
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
+(NSString*)getTmp{//3.获取tmp目录路径的方法
    NSLog(@"getTmp is %@",NSTemporaryDirectory());
    return NSTemporaryDirectory();
    
}
+(NSString*)getHomeDir{//4.获取沙盒根目录
    NSString* homeDir = NSHomeDirectory();
    return homeDir;
    
}
+(NSString*)getResoure:(NSString*)resoure withType:(NSString*)type{//5.获取应用程序程序包中资源文件路径的方法
    
    NSString* resourePath = [[NSBundle mainBundle]pathForResource:resoure ofType:type];
    return resourePath;
}
#pragma mark ============= 文件 目录 读取 end ==========================

#pragma mark =========  封装 (文件的操作) ========
+(void)createDir:(LKLFilePath)filePath addPath:(NSString*)fileName{
    
    NSString* filePathStr ;
    
    switch (filePath) {
        case LKLFileHomeDir:{//Home 沙盒根目录
            filePathStr =  NSHomeDirectory();
        }
            break;
        case LKLFileCaches:{//Caches
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileDocument:{//Document
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
            
        case LKLFileLibrary:{//Library
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileTmp:{//Tmp
            filePathStr = NSTemporaryDirectory();
        }
            break;
        case LKLFileResoure:{
            NSLog(@"test resoure");
            
        }
            break;
            
        default:
            break;
    }
    
    NSString* fileStr = [filePathStr stringByAppendingPathComponent:fileName];
    NSLog(@"file is %@",fileStr);
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //    创建目录
    BOOL res = [fileManager createDirectoryAtPath:fileStr withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"文件夹创建成功。");
    }else{
        NSLog(@"文件夹创建失败。");
    }
}

+(void)createFile:(LKLFilePath)filePath addPath:(NSString*)fileName{
    
    NSString* filePathStr ;
    
    switch (filePath) {
        case LKLFileHomeDir:{//Home 沙盒根目录
            filePathStr =  NSHomeDirectory();
        }
            break;
        case LKLFileCaches:{//Caches
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileDocument:{//Document
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
            
        case LKLFileLibrary:{//Library
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileTmp:{//Tmp
            filePathStr = NSTemporaryDirectory();
        }
            break;
        default:
            break;
    }
    
    NSString* file = [filePathStr stringByAppendingPathComponent:fileName];
    NSFileManager * fileManager  = [NSFileManager defaultManager];
    NSLog(@"file is create %@",file);
    BOOL res = [fileManager createFileAtPath:file contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功%@",file);
    }else{
        NSLog(@"文件创建失败");
    }
}

+(void)createDir:(LKLFilePath)filePath addPath:(NSString*)fileName fileSuccess:(successLKLBlock)fileToolSuccess failure:(failureLKLBlock)failure{
    
    NSString* filePathStr ;
    
    switch (filePath) {
        case LKLFileHomeDir:{//Home 沙盒根目录
            filePathStr =  NSHomeDirectory();
        }
            break;
        case LKLFileCaches:{//Caches
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileDocument:{//Document
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
            
        case LKLFileLibrary:{//Library
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileTmp:{//Tmp
            filePathStr = NSTemporaryDirectory();
        }
            break;
            
        case LKLFileResoure:{
            NSLog(@"test resoure");
        }
            break;
            
        default:
            break;
    }
    
    NSString* fileStr = [filePathStr stringByAppendingPathComponent:fileName];
    NSLog(@"file is %@",fileStr);
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //    创建目录
    BOOL res = [fileManager createDirectoryAtPath:fileStr withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        if (fileToolSuccess) {
            fileToolSuccess();
        }
        NSLog(@"文件夹创建成功。");
    }else{
        if (failure) {
            failure();
        }
        NSLog(@"文件夹创建失败。");
    }
}

+(void)createFile:(LKLFilePath)filePath addPath:(NSString*)fileName fileSuccess:(successLKLBlock)fileToolSuccess failure:(failureLKLBlock)failure{
    
    NSString* filePathStr ;
    
    switch (filePath) {
        case LKLFileHomeDir:{//Home 沙盒根目录
            filePathStr =  NSHomeDirectory();
        }
            break;
        case LKLFileCaches:{//Caches
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileDocument:{//Document
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
            
        case LKLFileLibrary:{//Library
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileTmp:{//Tmp
            filePathStr = NSTemporaryDirectory();
        }
            break;
        default:
            break;
    }
    
    NSString* file = [filePathStr stringByAppendingPathComponent:fileName];
    NSFileManager * fileManager  = [NSFileManager defaultManager];
    NSLog(@"file is create %@",file);
    BOOL res = [fileManager createFileAtPath:file contents:nil attributes:nil];
    if (res) {
        if (fileToolSuccess) {
            fileToolSuccess();
        }
        NSLog(@"文件创建成功%@",file);
    }else{
        if (failure) {
            failure();
        }
        NSLog(@"文件创建失败");
    }
    
}

+(void)deleteFile:(LKLFilePath)filePath addPath:(NSString *)fileName{
    
    NSString* filePathStr ;
    
    switch (filePath) {
        case LKLFileHomeDir:{//Home 沙盒根目录
            filePathStr =  NSHomeDirectory();
        }
            break;
        case LKLFileCaches:{//Caches
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileDocument:{//Document
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
            
        case LKLFileLibrary:{//Library
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileTmp:{//Tmp
            filePathStr = NSTemporaryDirectory();
        }
            break;
        default:
            break;
    }
    
    NSString* file = [filePathStr stringByAppendingPathComponent:fileName];
    NSFileManager*fileManager=[NSFileManager defaultManager];
    BOOL isSuccess=[fileManager removeItemAtPath:file error:nil];
    
    if(isSuccess){
        NSLog(@"delete success");
    }else{
        NSLog(@"delete fail");
    }
    
    
}

#pragma mark ===== write =========
+(void)writeContent:(NSString*)content toFile:(LKLFilePath)filePath andFileName:(NSString*)fileName{
    
    NSString* filePathStr ;
    
    switch (filePath) {
        case LKLFileHomeDir:{//Home 沙盒根目录
            filePathStr =  NSHomeDirectory();
        }
            break;
        case LKLFileCaches:{//Caches
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileDocument:{//Document
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
            
        case LKLFileLibrary:{//Library
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileTmp:{//Tmp
            filePathStr = NSTemporaryDirectory();
        }
            break;
        default:
            break;
    }
    
    NSString* file = [filePathStr stringByAppendingPathComponent:fileName];
    BOOL res = [content writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
    }else{
        NSLog(@"文件写入失败");
    }
}

+(void)writeImg:(UIImage*)image toFile:(LKLFilePath)filePath andFileName:(NSString*)fileName{
    
    NSString* filePathStr ;
    
    switch (filePath) {
        case LKLFileHomeDir:{//Home 沙盒根目录
            filePathStr =  NSHomeDirectory();
        }
            break;
        case LKLFileCaches:{//Caches
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileDocument:{//Document
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
            
        case LKLFileLibrary:{//Library
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
            filePathStr = [paths objectAtIndex:0];
        }
            break;
        case LKLFileTmp:{//Tmp
            filePathStr = NSTemporaryDirectory();
        }
            break;
        default:
            break;
    }
    
    NSString* file = [filePathStr stringByAppendingPathComponent:fileName];
    [UIImagePNGRepresentation(image)writeToFile:file atomically:YES];//写入文件中
}

+(NSString*)readFile:(NSString*)file{  //读取文件  file为文件名
    
    NSString* content = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"文件读取成功。%@",content);
    return content;
}
@end
