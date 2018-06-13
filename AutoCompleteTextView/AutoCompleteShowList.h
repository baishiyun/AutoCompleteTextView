//
//  AutoCompleteShowList.h
//  AutoCompleteTextViewDemo
//
//  Created by 白仕云 on 2018/6/13.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BSYTitleType,
    BSYTitleAndIcon,
} BSYCellType;

@interface AutoCompleteShowListCell : UITableViewCell
@property (nonatomic ,strong)UILabel *showText;
@end


@interface AutoCompleteShowList : UITableView


@property (nonatomic ,strong)NSMutableArray *dataArray;
@property (nonatomic ,copy)void(^BSYAutoCompleteShowTextBlock)(NSIndexPath *indexPath,AutoCompleteShowListCell *cell,id cellObj);

@property (nonatomic ,copy)void(^BSYDidSelectRowAtIndexPathBlock)(NSIndexPath *indexPath,AutoCompleteShowListCell *cell,id cellObj);

@end
