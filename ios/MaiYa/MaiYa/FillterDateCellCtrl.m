//
//  FillterDateCellCtrl.m
//  MaiYa
//
//  Created by zxl on 15/11/11.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "FillterDateCellCtrl.h"

@implementation FillterDateCellCtrl

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.lab.hidden = _isSelected;
    self.imgView.hidden = !_isSelected;
}

- (NSString *)identifierStr {
    if ([self.lab.text isEqualToString:@"上"]) {
        return @"AM";
    } else if ([self.lab.text isEqualToString:@"下"]) {
        return @"PM";
    } else {
        return @"AT";
    }
}

@end
