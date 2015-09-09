//
//  AdvisoryDetailViewController.m
//  MaiYa
//
//  Created by zxl on 15/9/7.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailViewController.h"
#import "AdvisoryDetailNumCell.h"
#import "AdvisoryDetailTimeCell.h"
#import "AdvisoryDetailTypeCell.h"
#import "AdvisoryDetailMasterCell.h"
#import "AdvisoryDetailServiceCell.h"
#import "AdvisoryDetailCommentCell.h"
#import "AdvisoryDetailEndCell.h"
#import "AdvisoryDetailDateCell.h"
#import "AdvisoryDetailPayCell0.h"
#import "AdvisoryDetailPayCell1.h"

@interface AdvisoryDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *identifiersArr;
@property (assign, nonatomic) BOOL isMaster;
@end

@implementation AdvisoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.identifiersArr = [NSMutableArray new];
    self.isMaster = YES;
    
    self.type = AdvisoryDetailTypeOfAll;
    [self setupIdentifiersArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)setupIdentifiersArr {
    switch (self.type) {
        case AdvisoryDetailTypeOfNonPayment:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailPayCell1"];
        }
            break;
            
        case AdvisoryDetailTypeOfGoingOn:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:self.isMaster? @"AdvisoryDetailMasterCell" : @"AdvisoryDetailUserCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
        }
            break;
            
        case AdvisoryDetailTypeOfNoComment:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:self.isMaster? @"AdvisoryDetailMasterCell" : @"AdvisoryDetailUserCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailCommentCell"];
        }
            break;
            
        case AdvisoryDetailTypeOfFinish:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:self.isMaster? @"AdvisoryDetailMasterCell" : @"AdvisoryDetailUserCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailEndCell"];
        }
            break;
            
        case AdvisoryDetailTypeOfOrdering:
        {
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailPayCell0"];
        }
            break;
            
        default:{
            [self.identifiersArr addObject:@"AdvisoryDetailNumCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTypeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailMasterCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailUserCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailTimeCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailServiceCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailCommentCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailEndCell"];
            [self.identifiersArr addObject:@"AdvisoryDetailPayCell0"];
            [self.identifiersArr addObject:@"AdvisoryDetailPayCell1"];
        }
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.identifiersArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indentifier = [self.identifiersArr objectAtIndex:indexPath.row];
    
    if ([indentifier isEqualToString:@"AdvisoryDetailNumCell"]) {
        AdvisoryDetailNumCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailTypeCell"]) {
        AdvisoryDetailTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailMasterCell"]) {
        AdvisoryDetailMasterCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailUserCell"]) {
        AdvisoryDetailUserCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailTimeCell"]) {
        AdvisoryDetailTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        [cell layoutAdvisoryDetailTimeCellSubviews];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailServiceCell"]) {
        AdvisoryDetailServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailCommentCell"]) {
        AdvisoryDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailEndCell"]) {
        AdvisoryDetailEndCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell0"]) {
        AdvisoryDetailPayCell0 *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell1"]) {
        AdvisoryDetailPayCell1 *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        return cell;
    } else {
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    NSString *indentifier = [self.identifiersArr objectAtIndex:indexPath.row];
    
    if ([indentifier isEqualToString:@"AdvisoryDetailNumCell"]) {
        height = 58;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailTypeCell"]) {
        height = 41;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailMasterCell"]) {
        height = 104;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailUserCell"]) {
        height = 104;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailTimeCell"]) {
        height = 33 + 70 * 7;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailServiceCell"]) {
        height = 80;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailCommentCell"]) {
        height = 340;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailEndCell"]) {
        height = 172;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell0"]) {
        height = 132;
    } else if ([indentifier isEqualToString:@"AdvisoryDetailPayCell1"]) {
        height = 315;
    } else {
        height = 0;
    }
    
    return height;
}

@end
