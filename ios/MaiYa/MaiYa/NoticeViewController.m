//
//  NoticeViewController.m
//  MaiYa
//
//  Created by zxl on 15/8/24.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeCell.h"

@interface NoticeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NoticeCell *commonCell;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [NSMutableArray new];
    
#warning test
    for (NSInteger index = 0; index < 20; ++ index) {
        NSString *title = @"优惠劵派发通知";
        NSString *date = @"2015-08-18  12:00:00";
        NSString *content = @"优惠劵派发通知测试;";
        NSInteger count = arc4random() % 99;
//        count = 50;
        for (NSInteger index1 = 0; index1 < count; ++ index1) {
            content = [NSString stringWithFormat:@"%@优惠劵派发通知测试%zd;", content, index1];
        }
        
        NSDictionary *dic = @{@"title": title, @"date": date, @"content": content};
        [self.dataArr addObject:dic];
    }
    
    self.commonCell = [self.tableView dequeueReusableCellWithIdentifier:@"NoticeCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeCell"];
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    [cell layoutNoticCellSubviewsByDic:dic];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    [self.commonCell layoutNoticCellSubviewsByDic:dic];
    
    CGSize contentViewSize = [self.commonCell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    CGSize textViewSize = [self.commonCell.contentTextView sizeThatFits:CGSizeMake(self.commonCell.contentTextView.width, FLT_MAX)];
    CGFloat height = contentViewSize.height + textViewSize.height;
    
    return height;
    
//    CGFloat contentWidth = self.commonCell.width;
//    UIFont *font = self.commonCell.contentLab.font;
//    NSString *content = self.commonCell.contentLab.text;
//    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
//    
//    CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
//    NSLog(@"height: %f", size.height);
//    return size.height + 1;
    
//    CGSize size = [self.commonCell.contentView systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
//    CGSize labSize = [self.commonCell.contentLab sizeThatFits:CGSizeMake(self.commonCell.contentLab.frame.size.width, FLT_MAX)];
//    NSLog(@"h=%f, labSize.h=%f", size.height + 1, labSize.height);
//    return 1  + size.height + labSize.height;
}

@end
