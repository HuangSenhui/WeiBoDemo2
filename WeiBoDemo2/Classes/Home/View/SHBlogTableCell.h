//
//  SHBlogTableCell.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SHStatusFrame;
@interface SHBlogTableCell : UITableViewCell

@property (nonatomic,strong) SHStatusFrame *statusFrame;

+ (instancetype) blogTableCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
