//
//  AMEUnderLineChooseView.h
//  QKProjectDemo
//
//  Created by AME on 2018/11/26.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class AMEUnderLineChooseView;
@protocol AMEUnderLineChooseViewDelegate <NSObject>
@optional
- (void)ame_underLineChooseView:(AMEUnderLineChooseView *)view didChangeIndex:(NSInteger)index;

@end

@interface AMEUnderLineChooseView : UIView

@property (nonatomic, weak) id <AMEUnderLineChooseViewDelegate> delegate;

@property (nonatomic, strong) UIFont * font;

@property (nonatomic, strong) UIColor * selectedColor;
@property (nonatomic, strong) UIColor * notSelectedColor;
@property (nonatomic, strong) UIColor * underLineColor;

@property (nonatomic, assign) CGFloat underLineLenth;
@property (nonatomic, assign) CGFloat underLineHeight;

@property (nonatomic, strong) NSArray<NSString *> * titleArray;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) CGFloat buttonWidth;


@end

NS_ASSUME_NONNULL_END
