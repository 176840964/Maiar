//
//  ZoneWorkingTimeView.m
//  MaiYa
//
//  Created by zxl on 15/10/8.
//  Copyright © 2015年 zhongqinglongtu. All rights reserved.
//

#import "ZoneWorkingTimeView.h"
#import "ZoneWorkingTimeCell.h"

@interface ZoneWorkingTimeView ()
@property (strong, nonatomic) IBOutletCollection(ZoneWorkingTimeCell) NSArray *timeCellsArr;
@end

@implementation ZoneWorkingTimeView

- (void)layoutZoneWorkingTimeViewSubviewsByWorkTimeStatusArr:(NSArray *)arr {
    self.timeCellsArr = [self.timeCellsArr sortByUIViewOriginX];
    
    for (NSInteger index = 0; index < arr.count; ++index) {
        NSDictionary *dic = [arr objectAtIndex:index];
        ZoneWorkingTimeCell *cell = [self.timeCellsArr objectAtIndex:index];
        [cell layoutZoneWorkingTimeCellSubviewsByDic:dic];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
