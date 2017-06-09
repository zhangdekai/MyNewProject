//
//  UITableView+YMHRefresh.m
//  CoreFrame
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "UITableView+YMHRefresh.h"

@implementation UITableView (YMHRefresh)

- (void)pullToHeaderRefreshWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)isRefreshingBlock {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:isRefreshingBlock];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

- (void)pullToFooterRefreshWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)isRefreshingBlock {
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:isRefreshingBlock];

//    footer.automaticallyHidden = YES;
//    [footer setTitle:@"没有更多内容了" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    
    //[self.mj_footer resetNoMoreData];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    footer.automaticallyChangeAlpha = NO;
    // 马上进入刷新状态
    //[footer beginRefreshing];
    
    // 设置header

    self.mj_footer = footer;
}

- (void)endFooterFreshWithHasNext:(BOOL)hasNext {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    if (!hasNext) {
        self.mj_footer.hidden = YES;
        [self.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self resetFooterViewState];
    }
}

- (void)endFooterFreshWithHasNext:(BOOL)hasNext andDatasCount:(NSInteger)datasCount{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    if (!hasNext) {
        self.mj_footer.hidden = YES;
        [self.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self resetFooterViewState];
    }
//    MJRefreshAutoStateFooter *footer = (MJRefreshAutoStateFooter *)self.mj_footer;
//    if (datasCount == 0) {
//        
//        [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
//    } else {
//        [footer setTitle:@"没有更多内容了" forState:MJRefreshStateNoMoreData];
//    }
}

- (void)resetFooterViewState {
    self.mj_footer.hidden = NO;
    self.mj_footer.state = MJRefreshStateIdle;
}
@end
