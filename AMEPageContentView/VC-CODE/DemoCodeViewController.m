//
//  DemoCodeViewController.m
//  AMEPageContentView
//
//  Created by AME on 2018/11/27.
//  Copyright © 2018 Qukuai. All rights reserved.
//

#import "DemoCodeViewController.h"
#import "AMEPageContentView.h"
#import "ChildViewController.h"

@interface DemoCodeViewController ()<AMEPageContentViewDelegate>

@property (nonatomic, strong) AMEPageContentView * contentView;
@property (nonatomic, strong) NSMutableArray<AMEPageContentItem *> *itemArray;

@end

@implementation DemoCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"code";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
}
#pragma mark - delegate
- (void)ame_pageContentView:(AMEPageContentView *)view didChangeIndex:(NSInteger)index{
    ChildViewController * vc = (ChildViewController *)view.itemArray[index].viewController;
//    vc.title = view.itemArray[index].title;
    [vc.tableView reloadData];
}

#pragma mark - getter & setter
- (AMEPageContentView *)contentView{
    if(!_contentView){
        _contentView = ({
            AMEPageContentView * object = [[AMEPageContentView alloc]initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kStatusBarAndNavigationBarHeight - kTabbarHeight) fatherViewController:self];
            object.itemArray        = self.itemArray;
            object.canScroll        = YES;
            object.buttonWidth      = 100;
            object.underLineLenth   = 100;
            object.underLineHeight  = 2;
            object.chooseViewHeight = 60;
            object.selectedColor    = [UIColor orangeColor];
            object.notSelectedColor = [UIColor greenColor];
            object.underLineColor   = [UIColor orangeColor];
            object.delegate         = self;
            object;
       });
    }
    return _contentView;
}

- (NSMutableArray<AMEPageContentItem *> *)itemArray{
    if(!_itemArray){
        _itemArray = ({
            ChildViewController * vc0 = [ChildViewController new];
            vc0.title = @"第0页";
            AMEPageContentItem * item0 = [AMEPageContentItem itemWithTitle:@"第0页" viewController:vc0];
            ChildViewController * vc1 = [ChildViewController new];
            vc1.title = @"第1页";
            AMEPageContentItem * item1 = [AMEPageContentItem itemWithTitle:@"第1页" viewController:vc1];
            ChildViewController * vc2 = [ChildViewController new];
            vc2.title = @"第2页";
            AMEPageContentItem * item2 = [AMEPageContentItem itemWithTitle:@"第2页" viewController:vc2];
            ChildViewController * vc3 = [ChildViewController new];
            vc3.title = @"第3页";
            AMEPageContentItem * item3 = [AMEPageContentItem itemWithTitle:@"第3页" viewController:vc3];
            ChildViewController * vc4 = [ChildViewController new];
            vc4.title = @"第4页";
            AMEPageContentItem * item4 = [AMEPageContentItem itemWithTitle:@"第4页" viewController:vc4];
            ChildViewController * vc5 = [ChildViewController new];
            vc5.title = @"第5页";
            AMEPageContentItem * item5 = [AMEPageContentItem itemWithTitle:@"第5页" viewController:vc5];
            
            NSMutableArray * object = @[item0, item1, item2,item3,item4,item5].mutableCopy;
            object;
       });
    }
    return _itemArray;
}
#pragma mark - 不要忘记添加这个方法
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}
@end
