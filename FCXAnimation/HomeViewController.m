//
//  HomeViewController.m
//  FCXAnimation
//
//  Created by fcx on 2019/9/11.
//  Copyright © 2019 fcx. All rights reserved.
//

#import "HomeViewController.h"
#import "FCXSimpleAnimationController.h"

static NSString *const HomeCellReuseID = @"HomeCellReuseID";

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"FCXAnimation";
    
    [self dataArray];
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCellReuseID forIndexPath:indexPath];
    if (_dataArray.count > indexPath.row) {
        cell.textLabel.text = _dataArray[indexPath.row][@"title"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_dataArray.count > indexPath.row) {
        NSDictionary *info = _dataArray[indexPath.row];
        NSString *className = info[@"controller"];
        if (!className) {
            NSLog(@"不存在的动画类型");
            return;
        }
        Class cls = NSClassFromString(className);
        if (!cls) {
            NSLog(@"找不到动画的类");
            return;
        }
        FCXSimpleAnimationController *controller = [[cls alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        if ([controller respondsToSelector:@selector(setupAnimation:)]) {
            [controller setupAnimation:info];
        }
    }
}

#pragma mark - get

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:HomeCellReuseID];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{
                           @"title" : @"圆点旋转",
                           @"controller" : @"FCXSimpleAnimationController",
                           @"animationClass" : @"FCXDotRotationAnimation"
                           },
                       @{
                           @"title" : @"下拉刷新（轨迹旋转动画）",
                           @"controller" : @"FCXPullRefreshController"
                           }
                       ];
    }
    return _dataArray;
}

@end
