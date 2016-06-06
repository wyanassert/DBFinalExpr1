//
//  UserHelper.h
//  DBFinalExpr1
//
//  Created by 万延 on 16/6/6.
//  Copyright © 2016年 万延. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlock) (NSError *error);

@interface UserHelper : NSObject

@property (nonatomic, strong) NSString *username;

+ (instancetype)sharedInstance;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password withBlock:(CompletionBlock)block;

- (void)signupWithUsername:(NSString *)username password:(NSString *)password withBlock:(CompletionBlock)block;

- (void)addGood:(NSString *)goodID withBlock:(CompletionBlock)block;

@end
