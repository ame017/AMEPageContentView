//
//  AMEPageContentBottomView.m
//  QKProjectDemo
//
//  Created by AME on 2018/11/26.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import "AMEPageContentBottomView.h"

#define SELF_WIDTH self.frame.size.width
#define SELF_HEIGHT self.frame.size.height

@interface AMEPageContentBottomView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NSMutableArray<UIViewController *> * didSetControllerArray;
@end

@implementation AMEPageContentBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
//    [self setUp];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame fatherViewController:(UIViewController *)fatherViewController{
    self = [super initWithFrame:frame];
    if (self) {
        self.fatherViewController = fatherViewController;
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)dealloc{
    for (UIViewController * vc in self.viewControllers) {
        [vc beginAppearanceTransition:NO animated:YES];
        [vc endAppearanceTransition];
    }
}

- (void)setUp{
    [self addSubview:self.scrollView];
}
- (void)layoutSubviews{
    self.scrollView.frame = CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
    if (self.didSetControllerArray.count) {
        self.scrollView.contentSize = CGSizeMake(self.viewControllers.count*SELF_WIDTH, SELF_HEIGHT);
        int i = 0;
        for (UIViewController * vc in self.viewControllers) {
            BOOL isFind = NO;
            for (UIViewController * didSetVc in self.didSetControllerArray) {
                if (didSetVc == vc) {
                    isFind = YES;
                }
            }
            if (isFind) {
                vc.view.frame = CGRectMake(i*SELF_WIDTH, 0, SELF_WIDTH, self.scrollView.frame.size.height);
            }
            i++;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger indexNow = self.index;
    _index = scrollView.contentOffset.x / SELF_WIDTH;
    if (indexNow != self.index) {
        [self.viewControllers[indexNow] beginAppearanceTransition:NO animated:YES];
        [self.viewControllers[indexNow] endAppearanceTransition];
        
        [self checkLoad];
        
        [self.viewControllers[self.index] beginAppearanceTransition:YES animated:YES];
        [self.viewControllers[self.index] endAppearanceTransition];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(ame_pageContentBottomView:didChangeIndex:)]) {
            [self.delegate ame_pageContentBottomView:self didChangeIndex:self.index];
        }
    }
}
- (void)checkLoad{
    if (self.viewControllers.count < self.index + 1) {
        return;
    }
    UIViewController * vc = self.viewControllers[self.index];
    BOOL isFind = NO;
    for (UIViewController * tempVC in self.didSetControllerArray) {
        if (tempVC == vc) {
            isFind = YES;
            break;
        }
    }
    if (!isFind) {
        vc.view.frame = CGRectMake(self.index*SELF_WIDTH, 0, SELF_WIDTH, self.scrollView.frame.size.height);
        if (self.fatherViewController) {
            [self.fatherViewController addChildViewController:vc];
        }
        [self.scrollView addSubview:vc.view];
        [self.didSetControllerArray addObject:vc];
    }
}
#pragma mark - getter & setter
- (void)setIndex:(NSInteger)index{
    NSInteger indexNow = self.index;
    _index = index;
    if (indexNow != self.index) {
        [self.viewControllers[indexNow] beginAppearanceTransition:NO animated:YES];
        [self.viewControllers[indexNow] endAppearanceTransition];
        
        [self checkLoad];
        
        [self.viewControllers[self.index] beginAppearanceTransition:YES animated:YES];
        
        [self.scrollView setContentOffset:CGPointMake(index*SELF_WIDTH, 0) animated:YES];
        
        [self.viewControllers[self.index] endAppearanceTransition];
    }
}
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers{
    if (_viewControllers) {
        for (UIViewController * vc in _viewControllers) {
            [vc.view removeFromSuperview];
            [vc removeFromParentViewController];
        }
    }
    _viewControllers = viewControllers;
    
    self.scrollView.contentSize = CGSizeMake(viewControllers.count*SELF_WIDTH, SELF_HEIGHT);
    //这里只加载第一页 (做懒加载)
    
    if (viewControllers.count) {
        UIViewController * vc = self.viewControllers[0];
        vc.view.frame = CGRectMake(0, 0, SELF_WIDTH, self.scrollView.frame.size.height);
        if (self.fatherViewController) {
            [self.fatherViewController addChildViewController:vc];
        }
        [self.scrollView addSubview:vc.view];
        [self.didSetControllerArray addObject:vc];
        [vc beginAppearanceTransition:YES animated:YES];
        [vc endAppearanceTransition];
    }
}
- (void)setFatherViewController:(UIViewController *)fatherViewController{
    _fatherViewController = fatherViewController;
    if (self.viewControllers.count) {
        for (UIViewController * vc in self.didSetControllerArray) {
            [vc removeFromParentViewController];
            [fatherViewController addChildViewController:vc];
        }
    }
}

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = ({
            UIScrollView * object = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT)];
            object.showsVerticalScrollIndicator   = NO;
            object.showsHorizontalScrollIndicator = NO;
            object.pagingEnabled                  = YES;
            object.delegate                       = self;
            object;
       });
    }
    return _scrollView;
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.scrollView.frame = CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
    if (self.didSetControllerArray.count) {
        self.scrollView.contentSize = CGSizeMake(self.viewControllers.count*SELF_WIDTH, SELF_HEIGHT);
        int i = 0;
        for (UIViewController * vc in self.viewControllers) {
            BOOL isFind = NO;
            for (UIViewController * didSetVc in self.didSetControllerArray) {
                if (didSetVc == vc) {
                    isFind = YES;
                }
            }
            if (isFind) {
                vc.view.frame = CGRectMake(i*SELF_WIDTH, 0, SELF_WIDTH, self.scrollView.frame.size.height);
            }
            i++;
        }
    }
}

- (NSMutableArray<UIViewController *> *)didSetControllerArray{
    if(!_didSetControllerArray){
        _didSetControllerArray = ({
            NSMutableArray * object = [[NSMutableArray alloc]init];
            object;
       });
    }
    return _didSetControllerArray;
}
@end
