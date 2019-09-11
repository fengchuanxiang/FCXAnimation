//
//  FCXPullRefreshController.m
//  FCXAnimation
//
//  Created by fcx on 2019/9/11.
//  Copyright © 2019 fcx. All rights reserved.
//

#import "FCXPullRefreshController.h"
#import "UIScrollView+FCXRefresh.h"
#import "FCXRefreshHeaderView.h"
#import "FCXRefreshFooterView.h"
#import "FCXDotLineAnimationRefreshHeaderView.h"
#import "FCXDotLinePathAnimation.h"

NSInteger PageCount = 20;
static NSString *const FCXPullRefreshCellReuseId = @"FCXPullRefreshCellReuseId";

@interface FCXPullRefreshController ()
{
    NSInteger _rows;
    FCXDotLinePathAnimation *_animationView;
}

@property (nonatomic, strong) FCXRefreshFooterView *refreshFooterView;

@end

@implementation FCXPullRefreshController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下拉刷新";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _rows = PageCount;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FCXPullRefreshCellReuseId];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self addRefreshView];
}

- (void)addRefreshView {
    __weak typeof(self) weakSelf = self;
    //下拉刷新
    FCXDotLineAnimationRefreshHeaderView *refreshHeaderView = [[FCXDotLineAnimationRefreshHeaderView alloc] initWithFrame:CGRectMake(0, -55, self.view.frame.size.width, 55)];
    refreshHeaderView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:refreshHeaderView];
    refreshHeaderView.refreshHandler = ^(FCXRefreshBaseView *refreshView) {
        [weakSelf refreshAction:refreshView];
    };
    
    //动画
    _animationView = [[FCXDotLinePathAnimation alloc] initWithFrame:CGRectMake(0, 100, self.tableView.frame.size.width, 55)];
    [self.tableView addSubview:_animationView];
    __weak FCXDotLinePathAnimation *weakAnimationView = _animationView;
    refreshHeaderView.progressHandler = ^(CGFloat pullingPercent) {
        weakAnimationView.progress = pullingPercent;
    };
    
    //上拉加载更多
    _refreshFooterView = [self.tableView addFooterWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        [weakSelf loadMoreAction];
    }];
    _refreshFooterView.autoLoadMore = YES;
}

- (void)refreshAction:(FCXRefreshBaseView *)refreshHeaderView {
    [_animationView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _rows = PageCount;
        [self.tableView reloadData];
        [refreshHeaderView endRefresh];
        [_animationView stopAnimating];
    });
}

- (void)loadMoreAction {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _rows += PageCount;
        [self.tableView reloadData];
        [_refreshFooterView endRefresh];
    });
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FCXPullRefreshCellReuseId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    return cell;
}

@end
