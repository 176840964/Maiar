//
//  PayViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/10.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "PayViewController.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AliPayModel.h"
#import "WechatPayModel.h"
#import "DataSigner.h"

#define AliPartner @"2088021510615456"
#define AliSeller @"zhifu@zmobi.cn"
#define AliPrivateKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMFGSMfgmKfkc0/B5OguGXpVmrGPM1wchT5w8/ccOlc1xNrXAsJfceBWlQU0qi0/R+J/bpJLnX0STlAlSthY9e3wSdxOnCnkZC/gEyQ4ypEAYzVpiqUW7raYYgxuCyZd+c0R76cyb9u5coL6IDx1o/8keG9i1+sLAXRg7USJVUr5AgMBAAECgYBo7DjymVEGRBT9hWs5SF14diSGpBDjvm/vV+55hg997KizjOnoj1wIx7ganV6NNb9WjIuATCBxF5EAHV6mWJUY5tpmmAz1YIwK61NubAuwnErWJ/VJObIgkmOpN49S/cfmyDFCbmF1jr6iDrAOHhK8CCMYSl7tk0sBhmg9W9iuAQJBAOwcqoYted/91ppOK3Z+UhSeIcgWxX72MVq96qTZC7vy6ze5rm4UNalYsb7OwBRhcNvRsw1wZLRXGwew0n0ovNkCQQDRjefIFxgcOI+H5KXe/hWBCVCvhD3j5uPBsMUg4Cwuj+iSgCcFos/ssqSf8FO11Eq2UP3UnH+EAcv2SS7icKshAkB4Vpvqyx7EtOE9v/2S5Qr8iyP4kPKTpPK+pvECl8TNRB/yRObMH+zBpPzinQl02bzlrFkvzkrlR0f1gX+mXq7xAkEAhcol+3fTKuFpsgdnZ3GtZQ7/dq/lm8XkD9u+X/j//FJg2Hf9cfm66pI7zOlxaJu7f59CECZCu5MyF3It/uCUQQJAeIO5zIDMsFSrcO7pIl4PCZHI7ibtrnLe+6P1m2bzzWu0qu06P4ey+qZUmoF1V1+E9QCqm3ZFns1+CvZ8WS6g/g=="
#define AliNotifyUrl @"http://123.56.107.102:33333/Pay/alipayNotifyUrl"

@interface PayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *needPayMoneyLab;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPaySuccess) name:@"NotificationForWechatPaySuccess" object:nil];
    
    self.needPayMoneyLab.text = [NSString stringWithFormat:@"%@元", self.moneyStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)navigationShouldPopOnBackButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NotificationForWechatPaySuccess" object:nil];
}

#pragma mark - 
- (void)wechatPaySuccess {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)payByWeChatModel:(WechatPayModel *)model {
    PayReq *req = [[PayReq alloc] init];
    req.openID = model.appid;
    req.partnerId = model.partnerid;
    req.prepayId = model.prepayid;
    req.nonceStr = model.noncestr;
    req.timeStamp = model.timestamp.intValue;
    req.package = model.package;
    req.sign = model.sign;
    [WXApi sendReq:req];
}

- (void)payByAliModel:(AliPayModel *)model {
    model.partner = AliPartner;
    model.seller = AliSeller;
    
    model.service = @"mobile.securitypay.pay";
    model.paymentType = @"1";
    model.inputCharset = @"utf-8";
    model.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在info.plist定义URL types
    NSString *appScheme = @"iOSMaiar";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [model description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(AliPrivateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
            NSString *result = [resultDic objectForKey:@"result"];
            if ([resultStatus isEqualToString:@"9000"] && result.isValid) {
                [[HintView getInstance] presentMessage:@"支付成功" isAutoDismiss:YES dismissBlock:^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            } else if ([resultStatus isEqualToString:@"6001"] && !result.isValid){
                [[HintView getInstance] presentMessage:@"支付取消" isAutoDismiss:YES dismissBlock:nil];
            } else {
                [[HintView getInstance] presentMessage:@"未知错误" isAutoDismiss:YES dismissBlock:nil];
            }
        }];
    }
}

#pragma mark - Networking
- (void)preDoPayWithTypeStr:(NSString *)type {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"doalipay" params:@{@"type": type, @"orderid": self.orderIdStr} success:^(id responseObject) {
        NSDictionary *resDic = [responseObject objectForKey:@"res"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([type isEqualToString:@"1"]) {
                NSLog(@"%@", resDic);
                WechatPayModel *model = [[WechatPayModel alloc] initWithDic:resDic];
                [self payByWeChatModel:model];
            } else {
                AliPayModel *model = [[AliPayModel alloc] initWithDic:resDic];
                [self payByAliModel:model];
            }
        });
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self preDoPayWithTypeStr:[NSString stringWithFormat:@"%zd", indexPath.row]];
}

@end
