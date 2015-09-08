//
//  AdvisoryDetailTimeCell.m
//  MaiYa
//
//  Created by zxl on 15/9/7.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailTimeCell.h"
#import "AdvisoryDetailDateCell.h"

@interface AdvisoryDetailTimeCell () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation AdvisoryDetailTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutAdvisoryDetailTimeCellSubviews {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdvisoryDetailDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvisoryDetailDateCell"];
    [cell layoutAdvisoryDetailDateCellSubviews];
    return cell;
}

#pragma mark - UITableViewDelegate

@end