//
//  SHTextView.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/20.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHTextView.h"

@interface SHTextView ()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation SHTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:16];
        self.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);   // 文本显示内间距: top,left,bottom,right
    }
    return self;
}
- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 16)];
        label.textColor = [UIColor darkGrayColor];
        [self addSubview:label];
        _placeholderLabel = label;
    }
    return _placeholderLabel;
}


- (void)setHidePlaceholder:(BOOL)hidePlaceholder {
    _hidePlaceholder = hidePlaceholder;
    self.placeholderLabel.hidden = hidePlaceholder;
}

#pragma mark - 重写父类的方法
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self.placeholderLabel sizeToFit];  // view bounds 会因字体而改变
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self.placeholderLabel sizeToFit];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    CGPoint placehoderOrigin = self.placeholderLabel.frame.origin;
//    CGSize placehoderFreme = self.placeholderLabel.frame.size;
//
//    //self.placeholderLabel.frame = CGRectMake(placehoderOrigin.x + 10, placehoderOrigin.y + 10, placehoderFreme.width, placehoderFreme.height);
//    self.placeholderLabel.frame = (CGRect){{placehoderOrigin.x + 10, placehoderOrigin.y + 10},placehoderFreme};
//}


@end
