

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 用制定的stroyboard构建ViewController
    ViewController *c = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateInitialViewController];
    
    // 创建一个导航栏的Controller UINavigationController中默认会有导航栏的UI 系统自带的
    // UINavigationController 类Activity栈
    UINavigationController *uiNavigationController = [[UINavigationController alloc]init];
    // 隐藏导航栏
    // navigation.navigationBar.hidden = YES;
    
    // Controller 类似Activity
    // 将ViewController交给uiNavigationController管理
    [uiNavigationController addChildViewController:c];
    
    // self.window.rootViewController = [navigation initWithRootViewController:c];
    // self.window.rootViewController = [uiNavigationController initWithRootViewController:self.window.rootViewController];
    self.window.rootViewController = uiNavigationController;
    return YES;
    
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
