//
//  AMEPageContentView.m
//  QKProjectDemo
//
//  Created by AME on 2018/11/26.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import "AMEPageContentView.h"

#import "AMEUnderLineChooseView.h"
#import "AMEPageContentBottomView.h"

#define SELF_WIDTH self.frame.size.width
#define SELF_HEIGHT self.frame.size.height

@interface AMEPageContentView ()<AMEUnderLineChooseViewDelegate, AMEPageContentBottomViewDelegate>

@property (nonatomic, strong) AMEUnderLineChooseView * chooseView;
@property (nonatomic, strong) AMEPageContentBottomView * bottomView;

@end

@implementation AMEPageContentView


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

- (void)setUp{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.chooseView];
    [self addSubview:self.bottomView];
}

- (void)layoutSubviews{
    self.chooseView.frame = CGRectMake(0, 0, SELF_WIDTH, self.chooseViewHeight);
    self.bottomView.frame = CGRectMake(0, self.chooseViewHeight, SELF_WIDTH, SELF_HEIGHT-self.chooseViewHeight);
}

- (void)fatherCallViewWillAppear{
    [self.bottomView fatherCallViewWillAppear];
}

#pragma mark - delegate
- (void)ame_underLineChooseView:(AMEUnderLineChooseView *)view didChangeIndex:(NSInteger)index{
    self.bottomView.index = index;
    _index = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ame_pageContentView:didChangeIndex:)]) {
        [self.delegate ame_pageContentView:self didChangeIndex:index];
    }
}
- (void)ame_pageContentBottomView:(AMEPageContentBottomView *)view didChangeIndex:(NSInteger)index{
    self.chooseView.index = index;
    _index = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ame_pageContentView:didChangeIndex:)]) {
        [self.delegate ame_pageContentView:self didChangeIndex:index];
    }
}

#pragma mark - getter & settter
- (void)setItemArray:(NSMutableArray<AMEPageContentItem *> *)itemArray{
    _itemArray = itemArray;
    NSMutableArray * titleArray = @[].mutableCopy;
    NSMutableArray * vcArray = @[].mutableCopy;
    for (AMEPageContentItem * item in itemArray) {
        [titleArray addObject:item.title];
        [vcArray addObject:item.viewController];
    }
    self.chooseView.titleArray = titleArray;
    self.bottomView.viewControllers = vcArray;
}
- (void)setChooseViewHeight:(CGFloat)chooseViewHeight{
    _chooseViewHeight = chooseViewHeight;
    self.chooseView.frame = CGRectMake(0, 0, SELF_WIDTH, chooseViewHeight);
    self.bottomView.frame = CGRectMake(0, chooseViewHeight, SELF_WIDTH, SELF_HEIGHT-chooseViewHeight);
}
- (void)setFont:(UIFont *)font{
    _font = font;
    self.chooseView.font = font;
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    self.chooseView.selectedColor = selectedColor;
}
- (void)setNotSelectedColor:(UIColor *)notSelectedColor{
    _notSelectedColor = notSelectedColor;
    self.chooseView.notSelectedColor = notSelectedColor;
}
- (void)setUnderLineColor:(UIColor *)underLineColor{
    _underLineColor = underLineColor;
    self.chooseView.underLineColor = underLineColor;
}
- (void)setUnderLineLenth:(CGFloat)underLineLenth{
    _underLineLenth = underLineLenth;
    self.chooseView.underLineLenth = underLineLenth;
}
- (void)setUnderLineHeight:(CGFloat)underLineHeight{
    _underLineHeight = underLineHeight;
    self.chooseView.underLineHeight = underLineHeight;
}
- (void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
    self.chooseView.canScroll = canScroll;
}
- (void)setButtonWidth:(CGFloat)buttonWidth{
    _buttonWidth = buttonWidth;
    self.chooseView.buttonWidth = buttonWidth;
}
- (void)setFatherViewController:(UIViewController *)fatherViewController{
    _fatherViewController = fatherViewController;
    self.bottomView.fatherViewController = fatherViewController;
}
- (void)setUnderLineViewBackgroundColor:(UIColor *)underLineViewBackgroundColor{
    _underLineViewBackgroundColor = underLineViewBackgroundColor;
    self.chooseView.backgroundColor = underLineViewBackgroundColor;
}
- (void)setBottomViewBackgroundColor:(UIColor *)bottomViewBackgroundColor{
    _bottomViewBackgroundColor = bottomViewBackgroundColor;
    self.bottomView.backgroundColor = bottomViewBackgroundColor;
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    self.chooseView.index = index;
    self.bottomView.index = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ame_pageContentView:didChangeIndex:)]) {
        [self.delegate ame_pageContentView:self didChangeIndex:index];
    }
}

- (AMEUnderLineChooseView *)chooseView{
    if(!_chooseView){
        _chooseView = ({
            AMEUnderLineChooseView * object = [[AMEUnderLineChooseView alloc]initWithFrame:CGRectMake(0, 0, SELF_WIDTH, 40)];
            object.delegate = self;
            object;
       });
    }
    return _chooseView;
}

- (AMEPageContentBottomView *)bottomView{
    if(!_bottomView){
        _bottomView = ({
            AMEPageContentBottomView * object = [[AMEPageContentBottomView alloc]initWithFrame:CGRectMake(0, 40, SELF_WIDTH, SELF_HEIGHT-40)];
            object.delegate = self;
            object;
       });
    }
    return _bottomView;
}
@end
