//
//  SHTextView.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/20.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHTextView : UITextView

@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,assign) BOOL hidePlaceholder;

@end

NS_ASSUME_NONNULL_END
