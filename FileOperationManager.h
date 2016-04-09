//
//  FileOperationManager.h
//  DataDemo
//
//  Created by LingKangLi on 16/1/8.
//  Copyright (c) 2016年 Kaly.Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^successLKLBlock)();
typedef void (^failureLKLBlock)();

typedef enum : NSUInteger {
    LKLFileDocument, //Document目录
    LKLFileCaches, //Caches目录
    LKLFileTmp, //Tmp目录
    LKLFileHomeDir, //HomeDir目录
    LKLFileResoure, //Resoure目录
    LKLFileLibrary //Library目录
} LKLFilePath;

@interface FileOperationManager : NSObject

#pragma mark ===== 获取目录 begin =======
#pragma mark 文件 目录 读取
+(NSString*)getDocuments;//1.获取Documents目录路径的方法
+(NSString*)getCaches;//2.获取Caches目录路径的方法
+(NSString*)getTmp;//3.获取tmp目录路径的方法
+(NSString*)getHomeDir;//4.获取家目录路径的方法
+(NSString*)getResoure:(NSString*)resoure withType:(NSString*)type;//5.获取应用程序程序包中资源文件路径的方法
+(NSString*)getLibrary;//6.获取Library目录
#pragma mark ===== 获取目录 end =======




#pragma mark ****************** 创建文件  begin *******************************

#pragma mark =========  封装 (文件的操作) ========
+(void)createDir:(LKLFilePath)filePath addPath:(NSString*)fileName;
//LKLFileHomeDir ，LKLFileCaches，LKLFileDocument，LKLFileLibrary，LKLFileTmp 这五种情况下是可行的。 (创建文件夹)

+(void)createFile:(LKLFilePath)filePath addPath:(NSString*)fileName;
//LKLFileHomeDir ，LKLFileCaches，LKLFileDocument，LKLFileLibrary，LKLFileTmp 这五种情况下是可行的。（创建文件）

#pragma mark =========  封装 (文件的操作)  block版========
+(void)createDir:(LKLFilePath)filePath addPath:(NSString*)fileName fileSuccess:(successLKLBlock)httpToolSuccess failure:(failureLKLBlock)failure;
+(void)createFile:(LKLFilePath)filePath addPath:(NSString*)fileName fileSuccess:(successLKLBlock)httpToolSuccess failure:(failureLKLBlock)failure;

#pragma mark ******************  创建文件  end *********************************


#pragma mark ****************** 删除文件 begin *********************************
+(void)deleteFile:(LKLFilePath)filePath addPath:(NSString*)fileName;
//LKLFileHomeDir ，LKLFileCaches，LKLFileDocument，LKLFileLibrary，LKLFileTmp 这五种情况下是可行的。（创建文件）


#pragma mark ****************** 删除文件 end *********************************


#pragma mark **************** 写入文件 begin **************************
+(void)writeContent:(NSString*)content toFile:(LKLFilePath)filePath andFileName:(NSString*)fileName;
+(void)writeImg:(UIImage*)image toFile:(LKLFilePath)filePath andFileName:(NSString*)fileName;

#pragma mark **************** 写入文件 end ****************************

+(NSString*)readFile:(NSString*)file;

@end
