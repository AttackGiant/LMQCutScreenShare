//
//  ViewController.m
//  LMQCutScreenShare
//
//  Created by attackGiant on 2017/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "Masonry.h"
#import "UIImage+ScreenPic.h"
@interface ViewController ()
//底部图片
@property (nonatomic, strong) UIImageView * imageView;

/**
 分享根视图
 */
@property (nonatomic, strong) UIView * sharView;

@property (nonatomic, strong) UIImageView *showView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加监听屏幕截图的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidScreenShort:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    self.imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.imageView.image = [UIImage imageNamed:@"风车.jpeg"];
    [self.view addSubview:self.imageView];
    [self loadShareView];
}
//加载分享视图
-(void)loadShareView{
    

    self.showView = [[UIImageView alloc]init];
    self.showView.layer.cornerRadius = 5;
    self.showView.userInteractionEnabled = YES;
    self.showView.layer.masksToBounds = YES;
    self.showView.backgroundColor = [UIColor whiteColor];
//    self.showView.image = image_;
    [self.view addSubview:self.showView];
    [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
//        make.centerY.equalTo(self.view.mas_centerY);
        make.top.mas_equalTo(self.view.mas_bottom);
        make.height.offset(KScreenHeight *0.5);
        
    }];
    
    
    
    self.sharView = [[UIView alloc]init];
    self.sharView.backgroundColor = [UIColor whiteColor];
    self.sharView.layer.cornerRadius = 8;
    [self.view addSubview:self.sharView];
    [self.sharView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.offset(70);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"分享到";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 3;
    [self.sharView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sharView);
        make.left.mas_equalTo(self.sharView).offset(10);
        make.width.offset(13);
        make.bottom.mas_equalTo(self.sharView);
    }];
    
    CGFloat w = (KScreenWidth - 178)/4;
    
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wechatBtn.tag = 1001;
    [wechatBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [wechatBtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
    [self.sharView addSubview:wechatBtn];
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).offset(25);
        //        make.top.mas_equalTo(self.sharView);
        make.centerY.mas_equalTo(self.sharView);
        make.size.mas_equalTo(CGSizeMake(w, w));
    }];
    
    UIButton *circleFir = [UIButton buttonWithType:UIButtonTypeCustom];
    circleFir.tag = 1002;
    [circleFir addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [circleFir setImage:[UIImage imageNamed:@"朋友圈 (1)"] forState:UIControlStateNormal];
    [self.sharView addSubview:circleFir];
    [circleFir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(wechatBtn.mas_right).offset(25);
        //        make.top.mas_equalTo(self.sharView);
        make.centerY.mas_equalTo(self.sharView);
        make.size.mas_equalTo(CGSizeMake(w, w));
    }];
    
    UIButton *QQ = [UIButton buttonWithType:UIButtonTypeCustom];
    QQ.tag = 1003;
    [QQ addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [QQ setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
    [self.sharView addSubview:QQ];
    [QQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(circleFir.mas_right).offset(25);
        //        make.top.mas_equalTo(self.sharView);
        make.centerY.mas_equalTo(self.sharView);
        make.size.mas_equalTo(CGSizeMake(w, w));
    }];
    UIButton *weibo = [UIButton buttonWithType:UIButtonTypeCustom];
    weibo.tag = 1004;
     [weibo addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [weibo setImage:[UIImage imageNamed:@"微博 (1)"] forState:UIControlStateNormal];
    [self.sharView addSubview:weibo];
    [weibo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(QQ.mas_right).offset(25);
        //        make.top.mas_equalTo(self.sharView);
        make.centerY.mas_equalTo(self.sharView);
        make.size.mas_equalTo(CGSizeMake(w, w));
    }];
    
}

#pragma mark 获取到截屏的通知后在此做处理
-(void)userDidScreenShort:(NSNotification *)notice{
    
    NSLog(@"用户截屏了哟");
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [UIImage imageWithScreenshot];
    self.showView.image = image_;
    //通过动画控制截图和分享视图的位置
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
    
        [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //
            self.showView.frame = CGRectMake(30, KScreenHeight *0.5 - KScreenHeight *0.25, KScreenWidth - 60, KScreenHeight *0.5);
            self.sharView.frame = CGRectMake(20, KScreenHeight - 120, KScreenWidth - 40, 70);
           
        } completion:^(BOOL finished) {
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                
                
                [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.showView.frame = CGRectMake(30, KScreenHeight, KScreenWidth - 60, KScreenHeight *0.5);
                    self.sharView.frame = CGRectMake(20, KScreenHeight, KScreenWidth - 40, 70);
                } completion:^(BOOL finished) {
                    
                }];
    
            });
            
        }];

    });
  
}

//分享action，分享功能自己集成
-(void)shareBtnClick:(UIButton *)sender{
  
    if (sender.tag == 1001) {
        NSLog(@"分享微信好友...");
    }if (sender.tag == 1002) {
         NSLog(@"分享朋友圈...");
    }if (sender.tag == 1003) {
         NSLog(@"分享QQ好友...");
    }if (sender.tag == 1004) {
         NSLog(@"分享微博...");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
