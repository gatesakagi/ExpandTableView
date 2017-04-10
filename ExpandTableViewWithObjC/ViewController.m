//
//  ViewController.m
//  ExpandTableViewWithObjC
//
//  Created by Gates on 2017/4/11.
//  Copyright © 2017年 Gates. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    // 陣列初始化
    if (!dataCellArray) {
        dataCellArray = [NSMutableArray array];
    }
    if (!isExpand) {
        isExpand = [NSMutableArray array];
    }
    if (!dataSectionArray) {
        dataSectionArray = [NSArray array];
    }
    
    // 個別塞資料進來
    dataSectionArray = @[@"華文文學", @"世界文學", @"類型文學"];
    dataCellArray = [NSArray arrayWithObjects:@[@"華文文學研究",@"華文文學研究",@"現代詩",@"現代詩",@"小說",@"華文文學人物傳記"],@[@"世界文學總論",@"神話/寓言",@"世界詩集",@"日本文學",@"英美文學",@"法國文學",@"德國文學",@"俄國文學",@"義大利文學",@"西葡語文學",@"其他各國文學",@"世界文學人物傳記"],@[@"驚悚／懸疑小說",@"推理小說",@"科幻小說",@"奇幻小說",@"武俠小說",@"歷史小說",@"大眾文學"],nil].mutableCopy;
    
    // 用0代表收起，非0（不一定是1）代表展開，預設為全部都是收起的狀態
    for (int i = 0; i < dataSectionArray.count; i++) {
        [isExpand addObject:@0];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataSectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 如果是展開狀態，則全部都秀出來，反之就為0
    NSArray *arrayCell = dataCellArray[section];
    if ([isExpand[section] boolValue]) {
        return arrayCell.count;
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [headerView setBackgroundColor:[UIColor grayColor]];
    
    UILabel *labelSectiontitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 44)];
    labelSectiontitle.text = [dataSectionArray objectAtIndex:section];
    labelSectiontitle.font = [UIFont boldSystemFontOfSize:22];
    labelSectiontitle.textColor = [UIColor whiteColor];
    [headerView addSubview:labelSectiontitle];
    
    UILabel *labelExpand = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, 0, 22, 44)];
    labelExpand.textColor = [UIColor whiteColor];
    if ([isExpand[section] boolValue]) {
        labelExpand.text = @"▼";
    } else {
        labelExpand.text = @"▶︎";
    }
    [headerView addSubview:labelExpand];
    
    UIButton *btnSection = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSection setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    btnSection.tag = 666 + section;
    [btnSection setBackgroundColor:[UIColor clearColor]];
    [btnSection addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btnSection];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = dataCellArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)buttonAction:(UIButton *)button {
    NSInteger section = button.tag - 666;
    
    isExpand[section] = [isExpand[section] isEqual:@0]?@1:@0;
    //上面一行是這個判斷式的簡式
    /*
     if ([isExpand[section] isEqual:@0]) {
     isExpand[section] = @1;
     } else {
     isExpand[section] = @0;
     }
     */
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

@end
