//
//  AppDelegate.m
//  DBFinalExpr1
//
//  Created by 万延 on 16/6/4.
//  Copyright © 2016年 万延. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "CYLTabBarController.h"
#import "GoodsCollectionViewController.h"
#import "LoginViewController.h"
#import "ShoppingCartCollectionViewController.h"
#import "UserHelper.h"
#import "ParseHeader.h"
#import "SellerGalleyCollectionViewController.h"
#import "PurchaseLogCollectionViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) CYLTabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Parse setApplicationId:@"dmTSjbYuvisrfUQAO9zxn2uyVxPQzUYjfo3fpmNk" clientKey:@"pNeLExhgqBEd2CJQSGjG3bO7aVA4GwzFLU9lnMbu"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginCompletion) name:@"Didlogin" object:nil];
    
    [self.window setRootViewController:[[LoginViewController alloc] init]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupViewControllers {
    GoodsCollectionViewController *firstViewController = [[GoodsCollectionViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    ShoppingCartCollectionViewController *secondViewController = [[ShoppingCartCollectionViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    SellerGalleyCollectionViewController *thirdViewController = [[SellerGalleyCollectionViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:thirdViewController];
    
    PurchaseLogCollectionViewController *fourthViewController = [[PurchaseLogCollectionViewController alloc] initWithType:PurchaseControllerTypePurchase];
    UIViewController *fourthNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:fourthViewController];
    
    PurchaseLogCollectionViewController *fifthViewController = [[PurchaseLogCollectionViewController alloc] initWithType:PurchaseControllerTypeSell];
    UIViewController *fifthNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:fifthViewController];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    if([[UserHelper sharedInstance].type isEqualToString:kParseUserTypeSeller])
    {
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController,
                                               thirdNavigationController,
                                               fourthNavigationController,
                                               fifthNavigationController,
                                               ]];
    }
    else
    {
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController,
                                               fourthNavigationController,
                                               ]];
    }
    self.tabBarController = tabBarController;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"购物",
                            CYLTabBarItemImage : @"image_main_shop",
                            CYLTabBarItemSelectedImage : @"image_main_shop",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"购物车",
                            CYLTabBarItemImage : @"image_shop_car",
                            CYLTabBarItemSelectedImage : @"image_shop_car",
                            };
    
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"我的商品",
                            CYLTabBarItemImage : @"image_main_good",
                            CYLTabBarItemSelectedImage : @"image_main_good",
                            };
    
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"购买记录",
                            CYLTabBarItemImage : @"image_main_log",
                            CYLTabBarItemSelectedImage : @"image_main_log",
                            };
    
    NSDictionary *dict5 = @{
                            CYLTabBarItemTitle : @"售出记录",
                            CYLTabBarItemImage : @"image_main_sell",
                            CYLTabBarItemSelectedImage : @"image_main_sell",
                            };
    
    if([[UserHelper sharedInstance].type isEqualToString:kParseUserTypeSeller])
    {
        NSArray *tabBarItemsAttributes = @[ dict1, dict2 , dict3, dict4, dict5];
        tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    }
    else
    {
        NSArray *tabBarItemsAttributes = @[ dict1, dict2, dict4];
        tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
    }
}

- (void)didLoginCompletion
{
    [self setupViewControllers];
    [self customizeTabBarForController:self.tabBarController];
    
    [self.window setRootViewController:nil];
    [self.window setRootViewController:self.tabBarController];
}

@end
