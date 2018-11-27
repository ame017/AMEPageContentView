//
//  AMEPageContentItem.m
//  QKProjectDemo
//
//  Created by AME on 2018/11/26.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import "AMEPageContentItem.h"

@implementation AMEPageContentItem

+ (instancetype)itemWithTitle:(NSString *)title viewController:(UIViewController *)viewController{
    AMEPageContentItem * item = [[AMEPageContentItem alloc]init];
    item.title = title;
    item.viewController = viewController;
    return item;
}

@end
