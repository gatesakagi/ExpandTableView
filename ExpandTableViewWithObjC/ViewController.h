//
//  ViewController.h
//  ExpandTableViewWithObjC
//
//  Created by Gates on 2017/4/11.
//  Copyright © 2017年 Gates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *dataCellArray;
    NSArray *dataSectionArray;
    NSMutableArray<NSNumber *> *isExpand;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

