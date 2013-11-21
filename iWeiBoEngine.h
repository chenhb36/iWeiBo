//
//  iWeiBoEngine.h
//  iWeiBo
//
//  Created by Alaysh on 11/16/13.
//  Copyright (c) 2013 Alaysh. All rights reserved.
//

#import "MKNetworkEngine.h"
@class UserModel;
/**
 *  调用成功
 *
 *  @since 1.0
 */
typedef void (^VoidBlock)(void);
/**
 *  调用失败
 *
 *  @since 1.0
 */
typedef void (^ErrorBlock)(NSError* engineError);
/**
 *  调用成功获取数据数组并处理
 *
 *  @param  weiBoArray  数据数组
 *
 *  @since 1.0
 */
typedef void (^SuccessBlock)(NSArray *weiBoArray);
/**
 *  调用成功获取用户信息并处理
 *
 *  @param aUser  返回的用户数据
 *
 *  @since 1.0
 */
typedef void (^SuccessBlockAccount)(UserModel *aUser);

@interface iWeiBoEngine : MKNetworkEngine
/// access_token    调用请求必带参数
@property (nonatomic,strong)NSString *accessToken;
/// uid 当前登录账号的uid
@property (nonatomic,strong)NSString *uid;
/// paramDic    调用请求所带的参数
@property (nonatomic,strong)NSMutableDictionary *paramDic;
/**
 *  初始化网络引擎
 *
 *  @param  anAccessToken    access_token    发送请求必带参数
 *
 *  @since 1.0
 *
 */
- (id)initWithAccessToken:(NSString*)anAccessToken;
/**
 *  登录
 *
 *  @param aCode   登陆时必带参数
 *  @param aSender 登录成功后调用调用者跳转页面
 *
 *  @since 1.0
 */
- (id)loginWithCode:(NSString*)aCode sender:(id)aSendeer;
/**
 *  退出登录
 *
 *  @since 1.0
 */
- (void)logout;
/**
 *  获取所有好友最新微博
 *
 *  @param  SuccessBlock  调用成功回调
 *  @param  ErrorBlock  调用失败回调
 *
 *  @since 1.0
 */
- (void)getFriendsWeibo:(SuccessBlock)successBlock onError:(ErrorBlock)errorBlock;
/**
 *  获取我的微博
 *
 *  @param  SuccessBlock  调用成功回调
 *  @param  ErrorBlock  调用失败回调
 *
 *  @since 1.0
 */
- (void)getMyWeibo:(SuccessBlock)successBlock onError:(ErrorBlock)errorBlock;
/**
 *  获取当前登录账号信息
 *
 *  @param  SuccessBlock    调用成功回调
 *  @param  ErrorBlock  调用失败回调
 *
 *  @since 1.0
 */
- (void)getAccountMessage:(SuccessBlockAccount)successBlock onError:(ErrorBlock)errorBlock;
/**
 *  获取当前登录账号好友列表
 *
 *  @param  SuccessBlock  调用成功回调
 *  @param  ErrorBlock  调用失败回调
 *
 *  @since 1.0
 */
- (void)getFriends:(SuccessBlock)successBlock onError:(ErrorBlock)errorBlock;
/**
 *  查询符合条件的所有用户
 *
 *  @param  SuccessBlock  调用成功回调
 *  @param  ErrorBlock  调用失败回调
 *
 *  @since 1.0
 */
- (void)findUsers:(NSString*)key onSuccess:(SuccessBlock)successBlock onError:(ErrorBlock)errorBlock;
/**
 *  查询某一用户
 *
 *  @param  SuccessBlock  调用成功回调
 *  @param  ErrorBlock  调用失败回调
 *
 *  @since 1.0
 */
- (void)findUser:(NSString*)uid onSuccess:(SuccessBlockAccount)successBlock onError:(ErrorBlock)errorBlock;
@end
