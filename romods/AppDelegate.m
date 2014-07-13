//
//  AppDelegate.m
//  romods
//
//  Created by Kosuke Nagano on 2014/07/11.
//  Copyright (c) 2014年 Kousuke Nagano. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize httpServer;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    httpServer = [[RoutingHTTPServer alloc] init];
    
    // ポート未指定の場合ランダムで設定されるので、適当なポート番号を指定する
    [httpServer setPort:SERVER_PORT];
    
    // ドキュメントルートに「htdocs」を指定する
    [httpServer setDocumentRoot:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"htdocs"]];

    //setup Routes
    [self setupRoutes];
    // HTTPサーバーを起動する
    [self startServer];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // HTTPサーバーを停止する
    [self stopServer];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // HTTPサーバーを起動する
    [self startServer];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private mehtods
/**
 HTTPサーバーを起動する
 */

- (void)startServer
{
    NSError *error;
    
    if (![httpServer start:&error]) {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
}

/**
 HTTPサーバーを停止する
 */
- (void)stopServer
{
    [httpServer stop];
}


#pragma mark - Route mehtods

- (void)setupRoutes {
    [httpServer get:@"/dialog" withBlock:^(RouteRequest *request, RouteResponse *response) {
        [response respondWithString:@"Hello!"];
    }];
    
    [httpServer get:@"/hello/:name" withBlock:^(RouteRequest *request, RouteResponse *response) {
        [response respondWithString:[NSString stringWithFormat:@"Hello %@!", [request param:@"name"]]];
        NSLog(@"hello %@", [request param:@"name"]);
    }];

    [httpServer get:@"\?dialog" withBlock:^(RouteRequest *request, RouteResponse *response) {
        // do something
        NSLog (@"?dialog");
    }];
    
    // Routes can also be handled through selectors
    [httpServer handleMethod:@"GET" withPath:@"/selector" target:self selector:@selector(handleSelectorRequest:withResponse:)];
}

- (void)handleSelectorRequest:(RouteRequest *)request withResponse:(RouteResponse *)response {
    [response respondWithString:@"Handled through selector"];
}




@end
