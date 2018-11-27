//
//  AMEUnderLineChooseView.m
//  QKProjectDemo
//
//  Created by AME on 2018/11/26.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import "AMEUnderLineChooseView.h"

#define SELF_WIDTH self.frame.size.width
#define SELF_HEIGHT self.frame.size.height

#define MIDDLE (SELF_WIDTH/2.0)


@interface AMEUnderLineChooseView ()

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) NSMutableArray<UIButton *> * buttonArray;

@end
@implementation AMEUnderLineChooseView

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
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.selectedColor    = [UIColor redColor];
    self.notSelectedColor = [UIColor blackColor];
    self.underLineColor   = [UIColor redColor];
    self.underLineHeight  = 1;
    self.underLineLenth   = 30;
    self.buttonWidth      = 60;
    self.font             = [UIFont systemFontOfSize:16.0f];
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.lineView];
}


#pragma mark - buttonClick
- (void)buttonClick:(UIButton *)button{
    self.index = button.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ame_underLineChooseView:didChangeIndex:)]) {
        [self.delegate ame_underLineChooseView:self didChangeIndex:button.tag];
    }
}

#pragma mark - getter & setter
- (void)setIndex:(NSInteger)index{
    _index = index;
    UIButton * button = self.buttonArray[index];
    for (UIButton * btn in self.buttonArray) {
        btn.selected = NO;
    }
    button.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.frame = CGRectMake((button.frame.size.width-self.underLineLenth)/2.0 + button.frame.origin.x, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height);
    }];
    if (self.canScroll) {
        //自动滚动
        if (self.scrollView.contentSize.width > SELF_WIDTH) {
            float move = self.scrollView.contentOffset.x+(button.frame.origin.x-self.scrollView.contentOffset.x-MIDDLE);
            if (move < 0) {
                move = 0;
            }else if (move > self.scrollView.contentSize.width - SELF_WIDTH){
                move = self.scrollView.contentSize.width - SELF_WIDTH;
            }
            [self.scrollView setContentOffset:CGPointMake(move,0) animated:YES];
        }
    }
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray{
    _titleArray = titleArray;
    
    for (UIButton * btn in self.buttonArray) {
        [btn removeFromSuperview];
    }
    [self.buttonArray removeAllObjects];
    
    //重新生成
    _index = 0;

    
    for (int i = 0; i < titleArray.count; i++) {
        UIButton * button = [[UIButton alloc]init];
        if (!self.canScroll) {
            button.frame = CGRectMake(0 + i*SELF_WIDTH/titleArray.count, 0, SELF_WIDTH/titleArray.count, SELF_HEIGHT-self.underLineHeight);
        }else{
            button.frame = CGRectMake(0 + i*self.buttonWidth, 0, self.buttonWidth, SELF_HEIGHT-self.underLineHeight);
        }
        button.tag = i;
        button.titleLabel.font = self.font;
        [button setTitleColor:self.selectedColor forState:UIControlStateSelected];
        [button setTitleColor:self.notSelectedColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        [self.buttonArray addObject:button];
        if (i == 0) {
            button.selected = YES;
            self.lineView.frame = CGRectMake((button.frame.size.width-self.underLineLenth)/2.0 + button.frame.origin.x, SELF_HEIGHT - self.underLineHeight, self.underLineLenth, self.underLineHeight);
        }
    }
    
    
    if (self.canScroll) {
        self.scrollView.contentSize = CGSizeMake(self.buttonArray.count * self.buttonWidth, SELF_HEIGHT);
    }else{
        self.scrollView.contentSize = CGSizeMake(SELF_WIDTH, SELF_HEIGHT);
    }
}

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = ({
            UIScrollView * object                 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT)];
            object.contentSize                    = CGSizeMake(SELF_WIDTH, SELF_HEIGHT);
            object.showsVerticalScrollIndicator   = NO;
            object.showsHorizontalScrollIndicator = NO;
            object;
       });
    }
    return _scrollView;
}

- (UIView *)lineView{
    if(!_lineView){
        _lineView = ({
            UIView * object = [[UIView alloc]init];
            object.backgroundColor = self.selectedColor;
            object;
        });
    }
    return _lineView;
}

- (NSMutableArray<UIButton *> *)buttonArray{
    if(!_buttonArray){
        _buttonArray = ({
            NSMutableArray * object = [[NSMutableArray alloc]init];
            object;
        });
    }
    return _buttonArray;
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    for (UIButton * button in self.buttonArray) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
}
- (void)setNotSelectedColor:(UIColor *)notSelectedColor{
    _notSelectedColor = notSelectedColor;
    for (UIButton * button in self.buttonArray) {
        [button setTitleColor:notSelectedColor forState:UIControlStateNormal];
    }
}
- (void)setFont:(UIFont *)font{
    _font = font;
    for (UIButton * button in self.buttonArray) {
        button.titleLabel.font = font;
    }
}
- (void)setUnderLineColor:(UIColor *)underLineColor{
    _underLineColor = underLineColor;
    self.lineView.backgroundColor = underLineColor;
}

- (void)setUnderLineLenth:(CGFloat)underLineLenth{
    _underLineLenth = underLineLenth;
    if (self.buttonArray.count) {
        UIButton * button = self.buttonArray[self.index];
        self.lineView.frame = CGRectMake((button.frame.size.width-underLineLenth)/2.0 + button.frame.origin.x, self.lineView.frame.origin.y, underLineLenth, self.lineView.frame.size.height);
    }
}
- (void)setUnderLineHeight:(CGFloat)underLineHeight{
    _underLineHeight = underLineHeight;
    if (self.buttonArray.count) {
        self.lineView.frame = CGRectMake(self.lineView.frame.origin.x, SELF_HEIGHT-underLineHeight, self.lineView.frame.size.width, underLineHeight);
    }
    for (UIButton * button in self.buttonArray) {
        button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, SELF_HEIGHT - underLineHeight);
    }
}

- (void)setButtonWidth:(CGFloat)buttonWidth{
    _buttonWidth = buttonWidth;
    if (self.buttonArray.count) {
        if (self.canScroll) {
            int i = 0;
            for (UIButton * button in self.buttonArray) {
                button.frame = CGRectMake(0 + i*self.buttonWidth, 0, self.buttonWidth, SELF_HEIGHT-self.underLineHeight);
                i++;
            }
            self.scrollView.contentSize = CGSizeMake(self.buttonArray.count * self.buttonWidth, SELF_HEIGHT);
        }
        UIButton * button = self.buttonArray[self.index];
        self.lineView.frame = CGRectMake((button.frame.size.width-self.underLineLenth)/2.0 + button.frame.origin.x, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height);
    }
}
- (void)setCanScroll:(BOOL)canScroll{
    _canScroll = canScroll;
    if (self.buttonArray.count) {
        if (canScroll) {
            int i = 0;
            for (UIButton * button in self.buttonArray) {
                button.frame = CGRectMake(0 + i*self.buttonWidth, 0, self.buttonWidth, SELF_HEIGHT-self.underLineHeight);
                i++;
            }
            self.scrollView.contentSize = CGSizeMake(self.buttonArray.count * self.buttonWidth, SELF_HEIGHT);
        }else{
            int i = 0;
            for (UIButton * button in self.buttonArray) {
                button.frame = CGRectMake(0 + i*SELF_WIDTH/self.titleArray.count, 0, SELF_WIDTH/self.titleArray.count, SELF_HEIGHT-self.underLineHeight);
                i++;
            }
            self.scrollView.contentSize = CGSizeMake(SELF_WIDTH, SELF_HEIGHT);
        }
        UIButton * button = self.buttonArray[self.index];
        self.lineView.frame = CGRectMake((button.frame.size.width-self.underLineLenth)/2.0 + button.frame.origin.x, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height);
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.scrollView.frame = CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
    if (self.buttonArray.count) {
        int i=0;
        for (UIButton * button in self.buttonArray) {
            if (!self.canScroll) {
                button.frame = CGRectMake(0 + i*SELF_WIDTH/self.titleArray.count, 0, SELF_WIDTH/self.titleArray.count, SELF_HEIGHT-self.underLineHeight);
            }else{
                button.frame = CGRectMake(0 + i*self.buttonWidth, 0, self.buttonWidth, SELF_HEIGHT-self.underLineHeight);
            }
            i++;
        }
        UIButton * button = self.buttonArray[self.index];
        self.lineView.frame = CGRectMake((button.frame.size.width-self.underLineLenth)/2.0 + button.frame.origin.x, SELF_HEIGHT - self.underLineHeight, self.underLineLenth, self.underLineHeight);
        if (self.canScroll) {
            self.scrollView.contentSize = CGSizeMake(self.buttonArray.count * self.buttonWidth, SELF_HEIGHT);
        }else{
            self.scrollView.contentSize = CGSizeMake(SELF_WIDTH, SELF_HEIGHT);
        }
    }
}

@end
