//
//  AMEPageContentView.h
//  QKProjectDemo
//
//  Created by AME on 2018/11/26.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMEPageContentItem.h"

NS_ASSUME_NONNULL_BEGIN
@class AMEPageContentView;
@protocol AMEPageContentViewDelegate <NSObject>
@optional

- (void)ame_pageContentView:(AMEPageContentView *)view didChangeIndex:(NSInteger)index;

@end

@interface AMEPageContentView : UIView

@property (nonatomic, weak) id<AMEPageContentViewDelegate> delegate;

/**
 标题字体
 */
@property (nonatomic, strong) UIFont * font;
/**
 被选中的标题的颜色
 */
@property (nonatomic, strong) UIColor * selectedColor;
/**
 没被选中的标题的颜色
 */
@property (nonatomic, strong) UIColor * notSelectedColor;
/**
 下划线颜色
 */
@property (nonatomic, strong) UIColor * underLineColor;
/**
 下划线长度 (默认30 建议不要超过标题的宽度)
 */
@property (nonatomic, assign) CGFloat underLineLenth;
/**
 下划线高度
 */
@property (nonatomic, assign) CGFloat underLineHeight;
/**
 当前位置
 */
@property (nonatomic, assign) NSInteger index;
/**
 标题栏的高度 默认40
 */
@property (nonatomic, assign) CGFloat chooseViewHeight;

/**
 上面控件的背景色
 */
@property (nonatomic, strong) UIColor * underLineViewBackgroundColor;

/**
 下面控件的背景色
 */
@property (nonatomic, strong) UIColor * bottomViewBackgroundColor;


/*---------------标题栏滚动支持---------------*/

/**
 标题是否可滚动
 */
@property (nonatomic, assign) BOOL canScroll;
/**
 标题宽度 (如果支持滚动，需要设置此项，如果不支持滚动设置此项无效)
 */
@property (nonatomic, assign) CGFloat buttonWidth;

/*---------------标题栏滚动支持---------------*/


/**
 用于确认viewController的父子关系,建议赋值,以免出现不必要的错误
 */
@property (nonatomic, weak) UIViewController * fatherViewController;

/**
 内容数组
 */
@property (nonatomic, strong) NSMutableArray<AMEPageContentItem *> * itemArray;

- (instancetype)initWithFrame:(CGRect)frame fatherViewController:(UIViewController *)fatherViewController;


/**
 把这个方法在父vc的viewWillAppear里调用，解决子页面的viewWillAppear的二次调用问题
 */
- (void)fatherCallViewWillAppear;


@end

NS_ASSUME_NONNULL_END
