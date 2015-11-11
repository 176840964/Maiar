//
//  FillterDateView.m
//  MaiYa
//
//  Created by zxl on 15/11/11.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "FillterDateView.h"

@implementation FillterDateView

- (void)layoutSubviewsWithTimestamp:(NSInteger)timestamp {
    self.timestamp = timestamp;
    
    NSString *dateStr = [CustomTools dateStringFromUnixTimestamp:timestamp withFormatString:@"MM.dd"];
    self.dateLab.text = dateStr;
    
    NSString *weekStr = [CustomTools dateStringFromUnixTimestamp:timestamp withFormatString:@"e"];
    weekStr = [CustomTools weekStringFormIndex:weekStr.integerValue];
    self.weekLab.text = weekStr;
    
    self.ctrlArr = [self.ctrlArr sortByUIViewOriginY];
    
    for (FillterDateCellCtrl *cellCtrl in self.ctrlArr) {
        cellCtrl.isSelected = NO;
        [cellCtrl addTarget:self action:@selector(onTapCellCtrl:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (NSString *)paraValueString {
    _paraValueString = nil;
    for (FillterDateCellCtrl *cellCtrl in self.ctrlArr) {
        if (cellCtrl.isSelected) {
            if (![_paraValueString isValid]) {
                _paraValueString = [NSString stringWithFormat:@"%zd", self.timestamp];
            }
            
            _paraValueString = [NSString stringWithFormat:@"%@-%@", _paraValueString, cellCtrl.identifierStr];
        }
    }
    
    return _paraValueString;
}

#pragma mark -
- (void)onTapCellCtrl:(FillterDateCellCtrl *)ctrl {
    ctrl.isSelected = !ctrl.isSelected;
}

@end
