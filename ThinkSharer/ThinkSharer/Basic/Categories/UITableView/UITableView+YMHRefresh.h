//
//  UITableView+YMHRefresh.h
//  CoreFrame
//
//  Created by 张德凯 on 2017/6/5.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface UITableView (YMHRefresh)

- (void)endFooterFreshWithHasNext:(BOOL)hasNext;//传入是否有下一页
- (void)endFooterFreshWithHasNext:(BOOL)hasNext andDatasCount:(NSInteger)datasCount;//传入是否有下一页、数据源个数
- (void)resetFooterViewState;//有切换页时候调用一下该方法重置footer
/**
 *  下拉刷新
 *
 *  @param isRefreshingBlock 进入刷新状态的回调
 */
- (void)pullToHeaderRefreshWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)isRefreshingBlock;

/**
 *  上拉加载更多
 *
 *  @param isRefreshingBlock 进入刷新状态的回调
 */
- (void)pullToFooterRefreshWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)isRefreshingBlock;

@end
