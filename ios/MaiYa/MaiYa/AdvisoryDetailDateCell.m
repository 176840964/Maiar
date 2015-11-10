//
//  AdvisoryDetailDateCell.m
//  MaiYa
//
//  Created by zxl on 15/9/7.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AdvisoryDetailDateCell.h"
#import "TimeCollectionViewCell.h"

@interface AdvisoryDetailDateCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataArr;
@end

@implementation AdvisoryDetailDateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutAdvisoryDetailDateCellSubviewsByORderDateModel:(OrderDateModel *)orderDateModel {
    self.dateLab.text = orderDateModel.dateStr;
    self.dataArr = orderDateModel.timesArr;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimeCollectionViewCell" forIndexPath:indexPath];
    
    NSString *timeStr = [self.dataArr objectAtIndex:indexPath.row];
    cell.timeLab.text = timeStr;
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(73, 28);
}

@end
