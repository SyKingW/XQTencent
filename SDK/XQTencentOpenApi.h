//
//  XQTencentOpenApi.h
//  XQShopMallProject
//
//  Created by WXQ on 2020/5/19.
//  Copyright © 2020 itchen.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class TencentOAuth;
@protocol TencentLoginDelegate;

/// 授权错误码
/// - XQTencentOpenApiAuthCodeSucceed: 授权成功
/// - XQTencentOpenApiAuthCodeError: 错误
/// - XQTencentOpenApiAuthCodeNetError: 网络错误
/// - XQTencentOpenApiAuthCodeCancel: 用户点击授权取消
typedef NS_ENUM(NSInteger, XQTencentOpenApiAuthCode) {
    XQTencentOpenApiAuthCodeSucceed = 0,
    XQTencentOpenApiAuthCodeError,
    XQTencentOpenApiAuthCodeNetError,
    XQTencentOpenApiAuthCodeCancel,
};

typedef void(^XQTencentSucceedCallback)(id responseObject);
typedef void(^XQTencentFailureCallback)(NSError *error);

typedef void(^XQTencentAuthCallback)(NSString *openId, XQTencentOpenApiAuthCode errcode);

@interface XQTencentOpenApi : NSObject

/// <#note#>
@property (nonatomic, weak) id <TencentLoginDelegate> loginDelegate;

/// <#note#>
@property (nonatomic, strong) TencentOAuth *tAuth;

+ (instancetype)manager;

/// 初始化 sdk
/// @param appId 腾讯那边给的 appi
+ (void)registerWithAppId:(NSString *)appId;

/// 发送授权信息
/// @param permissionsArr TencentOpenApi/sdkdef.h 里面 kOPEN_PERMISSION_GET_USER_INFO 这些
- (BOOL)sendAutInfoWithPermissionsArr:(NSArray <NSString *> *)permissionsArr;

/// 发送授权信息
- (BOOL)sendAutInfoWithPermissionsArr:(NSArray <NSString *> *)permissionsArr callback:(XQTencentAuthCallback)callback;

/// openURL 时告诉 sdk
+ (BOOL)handleOpenURLWithURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

/// 是否能够打开qq
+ (BOOL)isInstalled;

@end

NS_ASSUME_NONNULL_END
