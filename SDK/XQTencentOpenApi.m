//
//  XQTencentOpenApi.m
//  XQShopMallProject
//
//  Created by WXQ on 2020/5/19.
//  Copyright © 2020 itchen.com. All rights reserved.
//

#import "XQTencentOpenApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface XQTencentOpenApi () <TencentSessionDelegate, QQApiInterfaceDelegate>

/// <#note#>
@property (nonatomic, copy) NSString *appId;

/// <#note#>
@property (nonatomic, copy) XQTencentAuthCallback authCallback;

@end

@implementation XQTencentOpenApi

+ (instancetype)manager {
    static XQTencentOpenApi *manager_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager_ = [XQTencentOpenApi new];
    });
    return manager_;
}

// 注册wecaht sdk
+ (void)registerWithAppId:(NSString *)appId {
    
    [XQTencentOpenApi manager].appId = appId;
//    [XQTencentOpenApi manager].universalLink = appId;
//    [XQTencentOpenApi manager].appSecret = appId;
    
    [XQTencentOpenApi manager].tAuth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:[XQTencentOpenApi manager]];
//    [XQTencentOpenApi manager].tAuth.sessionDelegate = self;
}

// openURL 时告诉 wechat sdk
+ (BOOL)handleOpenURLWithURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [TencentOAuth HandleOpenURL:url];
//    return [QQApiInterface handleOpenURL:url delegate:[XQTencentOpenApi manager]];
}

// 是否能够打开微信 and 微信是否支持使用wxapi
+ (BOOL)isInstalled {
    return [QQApiInterface isQQInstalled];
}

#pragma mark - 分享

// 分享文字
- (void)sharedTextWithContent:(NSString *)content scene:(int)scene {
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = YES;
//    req.text = content;
//    req.scene = (int)scene;
//    [WXApi sendReq:req completion:^(BOOL success) {
//
//    }];
}

// 分享图片
- (void)sharedImageWithImageData:(NSData *)imageData mediaTagName:(NSString *)mediaTagName scene:(int)scene {
    
//    WXMediaMessage *mediaMessage = [WXMediaMessage message];
//    mediaMessage.messageExt = @"这个是 messageExt";
//    mediaMessage.messageAction = @"这个是 messageAction";
//
//    WXImageObject *imgObj = [WXImageObject object];
//    imgObj.imageData = imageData;
//    mediaMessage.mediaObject = imgObj;
//
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.scene = (int)scene;
//    req.message = mediaMessage;
//    [WXApi sendReq:req completion:^(BOOL success) {
//
//    }];
}

// 分享网页
- (void)sharedWebpageWithTitle:(NSString *)title description:(NSString *)description mediaTagName:(NSString *)mediaTagName thumbImage:(UIImage *)thumbImage webpageUrl:(NSString *)webpageUrl scene:(int)scene {
    
//    WXMediaMessage *mediaMessage = [WXMediaMessage message];
//    mediaMessage.title = title;
//    mediaMessage.description = description;
//    mediaMessage.mediaTagName = mediaTagName;
//    mediaMessage.messageExt = @"这个是 messageExt";
//    mediaMessage.messageAction = @"这个是 messageAction";
//    [mediaMessage setThumbImage:thumbImage];
//
//    WXWebpageObject *imgObj = [WXWebpageObject object];
//    imgObj.webpageUrl = webpageUrl;
//    mediaMessage.mediaObject = imgObj;
//
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.text = title;
//    req.scene = (int)scene;
//    req.message = mediaMessage;
//    [WXApi sendReq:req completion:^(BOOL success) {
//
//    }];
}

#pragma mark - 授权

/// 发送授权信息
- (BOOL)sendAutInfoWithPermissionsArr:(NSArray <NSString *> *)permissionsArr {
    if (![XQTencentOpenApi isInstalled]) {
        [self authCallbackWithErrcode:XQTencentOpenApiAuthCodeError];
        return NO;
    }
    
    if ([self.tAuth authorize:permissionsArr inSafari:NO]) {
        return YES;
    }
    
    [self authCallbackWithErrcode:XQTencentOpenApiAuthCodeError];
    return NO;
}

- (BOOL)sendAutInfoWithPermissionsArr:(NSArray <NSString *> *)permissionsArr callback:(XQTencentAuthCallback)callback {
    self.authCallback = callback;
    return [self sendAutInfoWithPermissionsArr:permissionsArr];
}

- (void)authCallbackWithErrcode:(XQTencentOpenApiAuthCode)errcode {
    if (self.authCallback) {
        self.authCallback(self.tAuth.openId, errcode);
        self.authCallback = nil;
    }
}

#pragma mark - request

// 通过微信返回的code, 获取用户wechat信息
- (void)getWechatTokenWithCode:(NSString *)code succeed:(XQTencentSucceedCallback)succeed failure:(XQTencentFailureCallback)failure {
//    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", self.appId, self.appSecret, code];
//    [self get:url success:succeed failure:failure];
}

// 刷新 token 时间
- (void)refresh_tokenWithRefresh_token:(NSString *)refresh_token succeed:(XQTencentSucceedCallback)succeed failure:(XQTencentFailureCallback)failure {
//    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", self.appId, refresh_token];
//    [self get:url success:succeed failure:failure];
}

// 检验 token 是否有效
- (void)checkoutTokenWithAccess_token:(NSString *)access_token openid:(NSString *)openid succeed:(XQTencentSucceedCallback)succeed failure:(XQTencentFailureCallback)failure {
//    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/auth?access_token=%@&openid=%@", access_token, openid];
//    [self get:url success:succeed failure:failure];
}

// 获取用户信息
- (void)getUserinfoWithAccess_token:(NSString *)access_token openid:(NSString *)openid lang:(NSString *)lang succeed:(XQTencentSucceedCallback)succeed failure:(XQTencentFailureCallback)failure {
//    NSString *url = nil;
//    if (lang.length != 0) {
//        url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@&lang=%@", access_token, openid, lang];
//    }else {
//        url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", access_token, openid];
//    }
//    
//    [self get:url success:succeed failure:failure];
}


/**
 基础 get 请求
 */
- (NSURLSessionDataTask *)get:(NSString *)urlStr success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"Get";
    
    // 设置 header
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{}
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    request.HTTPBody = jsonData;
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        } else {
            NSError *e = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
            if (e) {
                NSLog(@"解析data失败: %@", e);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                success(dict);
            });
        }
        
    }];
    
    [dataTask resume];
    return dataTask;
}


#pragma mark - TencentSessionDelegate

/**
 * 退出登录的回调
 */
- (void)tencentDidLogout {
    NSLog(@"%s", __func__);
}

/**
 * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \param permissions 需增量授权的权限列表。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions {
    NSLog(@"%s", __func__);
    return YES;
}

/**
 * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth {
    NSLog(@"%s", __func__);
    return YES;
}

/**
 * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
 * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
 * \note 第三方应用需更新已保存的token及有效期限等信息。
 */
- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth {
    NSLog(@"%s", __func__);
}

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
- (void)tencentFailedUpdate:(UpdateFailType)reason {
    NSLog(@"%s", __func__);
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response {
    NSLog(@"%s", __func__);
}



/**
 * 社交API统一回调接口
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \param message 响应的消息，目前支持‘SendStory’,‘AppInvitation’，‘AppChallenge’，‘AppGiftRequest’
 */
- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message {
    NSLog(@"%s", __func__);
}

/**
 * post请求的上传进度
 * \param tencentOAuth 返回回调的tencentOAuth对象
 * \param bytesWritten 本次回调上传的数据字节数
 * \param totalBytesWritten 总共已经上传的字节数
 * \param totalBytesExpectedToWrite 总共需要上传的字节数
 * \param userData 用户自定义数据
 */
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite userData:(id)userData {
    NSLog(@"%s", __func__);
}


/**
 * 通知第三方界面需要被关闭
 * \param tencentOAuth 返回回调的tencentOAuth对象
 * \param viewController 需要关闭的viewController
 */
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController {
    NSLog(@"%s", __func__);
}

#pragma mark - TencentLoginDelegate


/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin {
    NSLog(@"%s", __func__);
    [self.loginDelegate tencentDidLogin];
    
    [self authCallbackWithErrcode:XQTencentOpenApiAuthCodeSucceed];
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    NSLog(@"%s", __func__);
    [self.loginDelegate tencentDidNotLogin:cancelled];
    
    if (cancelled) {
        [self authCallbackWithErrcode:XQTencentOpenApiAuthCodeCancel];
    }else {
        [self authCallbackWithErrcode:XQTencentOpenApiAuthCodeError];
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork {
    NSLog(@"%s", __func__);
    [self.loginDelegate tencentDidNotNetWork];
    [self authCallbackWithErrcode:XQTencentOpenApiAuthCodeNetError];
}

//@optional
/**
 * 登录时权限信息的获得
 */
//- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams {}


#pragma mark - QQApiInterfaceDelegate

/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req {
    NSLog(@"%s", __func__);
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp {
    NSLog(@"%s", __func__);
    NSLog(@"%@", resp);
    
//    if ([resp isKindOfClass:[SendAuthResp class]]) {
//        // 是认证回调
//        // 强转获取code
//        SendAuthResp *authResp = (SendAuthResp *)resp;
//        NSString *code = authResp.code;
//        if ([self.delegate respondsToSelector:@selector(wechatReceiveAutWithCode:errCode:)]) {
//            [self.delegate wechatReceiveAutWithCode:code errCode:resp.errCode];
//        }
//
//    }else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
//
//        NSLog(@"错误码: %d, %@", resp.errCode, resp.errStr);
//
//    }else if ([resp isKindOfClass:[PayResp class]]) {
//
//        // 支付
//        if ([self.delegate respondsToSelector:@selector(wechatReceivePayWithResp:)]) {
//            [self.delegate wechatReceivePayWithResp:resp];
//        }
//
//    }
    
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response {
    NSLog(@"%s", __func__);
}


@end
