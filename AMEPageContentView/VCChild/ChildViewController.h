//
//  ChildViewController.h
//  AMEPageContentView
//
//  Created by AME on 2018/11/27.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UI_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define UI_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREENSIZE_IS_35  (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define SCREENSIZE_IS_40  (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define SCREENSIZE_IS_47  (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define SCREENSIZE_IS_55  (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0)

//判断iPHoneXr
#define SCREENSIZE_IS_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

//判断iPHoneX、iPHoneXs
#define SCREENSIZE_IS_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
#define SCREENSIZE_IS_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

//判断iPhoneXs Max
#define SCREENSIZE_IS_XS_MAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)


// Status bar height.
#define  kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

// Navigation bar height.
#define  kNavigationBarHeight self.navigationController.navigationBar.frame.size.height

// Tabbar height.
#define  kTabbarHeight         (kTabbarSafeBottomMargin + 49.f)

// Tabbar safe bottom margin.
#define  kTabbarSafeBottomMargin         (IS_IPhoneX_All ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  kStatusBarAndNavigationBarHeight (kStatusBarHeight+kNavigationBarHeight)

#define kViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

NS_ASSUME_NONNULL_BEGIN

@interface ChildViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
