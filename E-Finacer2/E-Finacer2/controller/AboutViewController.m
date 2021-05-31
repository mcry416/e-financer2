//
//  AboutViewController.m
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/30.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel * labelContent = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 300)];
    labelContent.text = @"尊敬的用户，您好！E-金融是一款符合“互联网+”的金融科技产品，为数以百万计的用户提供琳琅满目的贷款方案：从低至万分之四的“轻享e借生活”的日息套餐，到审批不足半个工作日的无抵押信用刚需贷款“随行e键信用”，乃至小微企业的资质重组融借方案“友借e连企业”都遍布我们的产品。选择E-金融，就是选择未来！";
    labelContent.numberOfLines = 0;
    [self.view addSubview:labelContent];
    
    UIButton * buttonDone = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonDone setTitle:@"我已知晓" forState:(UIControlStateNormal)];
    buttonDone.frame = CGRectMake((self.view.frame.size.width/2 - 25), (self.view.frame.size.height - 130), 70, 30);
    [buttonDone addTarget:self action:@selector(dismissListener) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:buttonDone];
    
    [self initView];
    
    [self installLabelContent];
}

- (void) installLabelContent{
    
}

- (void) initView{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) dismissListener{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

