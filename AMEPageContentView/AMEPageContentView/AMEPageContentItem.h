//
//  AMEPageContentItem.h
//  QKProjectDemo
//
//  Created by AME on 2018/11/26.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMEPageContentItem : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) UIViewController * viewController;

+ (instancetype)itemWithTitle:(NSString *)title viewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
