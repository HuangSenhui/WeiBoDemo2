//
//  SHEditorViewController.m
//  WeiBoDemo2
//  微博编辑界面
//  Created by HuangSenhui on 2019/5/19.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHEditorViewController.h"

#import "SHTextView.h"
#import "SHSendBlog.h"

#import <MBProgressHUD.h>

@interface SHEditorViewController () <UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,weak) SHTextView *editorView;      // 编辑视图
@property (nonatomic,weak) UITableView *toolsView;      // 工具视图
@property (nonatomic,weak) UITableView *photoView;      // 图片视图

@property (nonatomic,weak) UIButton *sendButton;        // 发送按钮

@end

@implementation SHEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航栏
    [self setupNavigationBar];
    // 编辑区
    [self setupEditorView];
    // 工具栏
    
    // 键盘
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - navigation
- (void) setupNavigationBar {
    // 界面标题
    self.navigationItem.title = @"发微博";
    // 取消按钮
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cancelBtn addTarget:self action:@selector(reblackToMianUI) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    // 发送按钮
    UIButton *sendBtn = [[UIButton alloc] init];
    _sendButton = sendBtn;
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBlog) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    
}

- (void)reblackToMianUI {
    [self.editorView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendBlog {
    NSLog(@"发微博 click");
    [SHSendBlog sendBlogWithText:_editorView.text success:^(SHStatus *status) {
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.label.text = @"发送成功";
        [self reblackToMianUI];
    } failure:^(NSError * _Nonnull error) {
        MBProgressHUD *mbp = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mbp.label.text = @"失败";
    }];
    
}
- (void)setupEditorView {
    SHTextView *editorView = [[SHTextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:editorView];
    // 设置占位符
    editorView.placeholder = @"分享新鲜事...";
    editorView.font = [UIFont systemFontOfSize:16];
    // 默认允许垂直方向拖拽
    editorView.alwaysBounceVertical = YES;
    
    editorView.delegate = self;
    _editorView = editorView;
}

#pragma mark - textViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    if ([_editorView.text length] > 0 && [_editorView.text length] <= 140) {
        _editorView.hidePlaceholder = YES;
        self.sendButton.enabled = YES;
        [self.sendButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self blogTextLength:(int)_editorView.text.length];
    } else {
        _editorView.hidePlaceholder = NO;
        self.sendButton.enabled = NO;
        [self.sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.editorView resignFirstResponder];
}

// 字数判断
- (void)blogTextLength:(int)length {
    if (length > 140) {
        NSString *textCount = [NSString stringWithFormat:@"已编辑%d个字，超出140个字",length];
        NSLog(@"%@",textCount);
    }
}

@end
