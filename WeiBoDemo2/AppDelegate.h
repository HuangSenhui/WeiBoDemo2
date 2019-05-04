//
//  AppDelegate.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/4.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

