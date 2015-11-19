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
#import "AliOrderModel.h"
#import "DataSigner.h"

#define AliPartner @"2088021510615456"
#define AliSeller @"zhifu@zmobi.cn"
#define AliPrivateKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMFGSMfgmKfkc0/B5OguGXpVmrGPM1wchT5w8/ccOlc1xNrXAsJfceBWlQU0qi0/R+J/bpJLnX0STlAlSthY9e3wSdxOnCnkZC/gEyQ4ypEAYzVpiqUW7raYYgxuCyZd+c0R76cyb9u5coL6IDx1o/8keG9i1+sLAXRg7USJVUr5AgMBAAECgYBo7DjymVEGRBT9hWs5SF14diSGpBDjvm/vV+55hg997KizjOnoj1wIx7ganV6NNb9WjIuATCBxF5EAHV6mWJUY5tpmmAz1YIwK61NubAuwnErWJ/VJObIgkmOpN49S/cfmyDFCbmF1jr6iDrAOHhK8CCMYSl7tk0sBhmg9W9iuAQJBAOwcqoYted/91ppOK3Z+UhSeIcgWxX72MVq96qTZC7vy6ze5rm4UNalYsb7OwBRhcNvRsw1wZLRXGwew0n0ovNkCQQDRjefIFxgcOI+H5KXe/hWBCVCvhD3j5uPBsMUg4Cwuj+iSgCcFos/ssqSf8FO11Eq2UP3UnH+EAcv2SS7icKshAkB4Vpvqyx7EtOE9v/2S5Qr8iyP4kPKTpPK+pvECl8TNRB/yRObMH+zBpPzinQl02bzlrFkvzkrlR0f1gX+mXq7xAkEAhcol+3fTKuFpsgdnZ3GtZQ7/dq/lm8XkD9u+X/j//FJg2Hf9cfm66pI7zOlxaJu7f59CECZCu5MyF3It/uCUQQJAeIO5zIDMsFSrcO7pIl4PCZHI7ibtrnLe+6P1m2bzzWu0qu06P4ey+qZUmoF1V1+E9QCqm3ZFns1+CvZ8WS6g/g=="
#define AliNotifyUrl @"http://123.56.107.102:33333/?m=home&c=Pay&a=alipayNotifyUrl"

@interface PayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *needPayMoneyLab;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *moneyStr = [UserConfigManager shareManager].createOrderViewModel.moneyStr;
    self.needPayMoneyLab.text = [NSString stringWithFormat:@"%.2f元", moneyStr.floatValue / 100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)navigationShouldPopOnBackButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
    return YES;
}

#pragma mark - 
- (void)payByWeChat {
    //从服务器获取支付参数，服务端自定义处理逻辑和格式
    //订单标题
    NSString *ORDER_NAME    = @"Ios服务器端签名支付 测试";
    //订单金额，单位（元）
    NSString *ORDER_PRICE   = @"0.01";
    
    //根据服务器端编码确定是否转码
    NSStringEncoding enc;
    //if UTF8编码
    //enc = NSUTF8StringEncoding;
    //if GBK编码
    enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *urlString = [NSString stringWithFormat:@"%@?plat=ios&order_no=%@&product_name=%@&order_price=%@",
                           WeChat_SP_URL,
                           [[NSString stringWithFormat:@"%ld",time(0)] stringByAddingPercentEscapesUsingEncoding:enc],
                           [ORDER_NAME stringByAddingPercentEscapesUsingEncoding:enc],
                           ORDER_PRICE];
    
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.openID              = [dict objectForKey:@"appid"];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }else{
                [CustomTools simpleAlertShow:@"提示信息" content:[dict objectForKey:@"retmsg"] container:nil];
            }
        }else{
            [CustomTools simpleAlertShow:@"提示信息" content:@"服务器返回错误，未获取到json对象" container:nil];
        }
    }else{
        [CustomTools simpleAlertShow:@"提示信息" content:@"服务器返回错误" container:nil];
    }
}

- (void)payByAli {
    AliOrderModel *order = [[AliOrderModel alloc] init];
    order.partner = AliPartner;
    order.seller = AliSeller;
    order.tradeNO = [UserConfigManager shareManager].createOrderViewModel.orderIdStr;
    order.productName = [[UserConfigManager shareManager].createOrderViewModel getOrderSubject]; //商品标题
    order.productDescription = [[UserConfigManager shareManager].createOrderViewModel getOrderBody]; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f", [UserConfigManager shareManager].createOrderViewModel.moneyStr.floatValue]; //商品价格
    order.amount = @"0.01"; //商品价格
    order.notifyURL =  AliNotifyUrl; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
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
        }];
    }
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
    if (0 == indexPath.row) {
        [self payByWeChat];
    } else {
        [self payByAli];
    }
}

@end
