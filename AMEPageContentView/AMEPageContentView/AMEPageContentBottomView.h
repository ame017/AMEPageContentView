//
//  AMEPageContentBottomView.h
//  QKProjectDemo
//
//  Created by AME on 2018/11/26.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AMEPageContentBottomView;
@protocol AMEPageContentBottomViewDelegate <NSObject>
@optional
- (void)ame_pageContentBottomView:(AMEPageContentBottomView *)view didChangeIndex:(NSInteger)index;

@end

@interface AMEPageContentBottomView : UIView
@property (nonatomic, weak) id<AMEPageContentBottomViewDelegate> delegate;
@property (nonatomic, strong) NSArray<UIViewController *> * viewControllers;
@property (nonatomic, weak) UIViewController * fatherViewController;
@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithFrame:(CGRect)frame fatherViewController:(UIViewController *)fatherViewController;

- (void)fatherCallViewWillAppear;

@end

NS_ASSUME_NONNULL_END
