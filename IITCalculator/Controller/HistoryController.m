//
//  HistoryController.m
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-30.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import "AppDelegate.h"

#import "HistoryController.h"
#import "HistoryCell.h"
#import "History.h"
#import "FormatUtils.h"

@interface HistoryController () {

    AppDelegate *appDelegate;
    NSManagedObjectContext *managedObjectContext;
}

// outlets
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) UISearchDisplayController *searchController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *searchFetchedResultsController;

@end

@implementation HistoryController {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    
    [self initUI];
}

- (void)initUI {    
    self.title = @"历史纪录";

    UIImage * backgroundImage = [UIImage imageNamed:@"BackgroundTexture"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editHistory)];
    
    [self initTableViewUI];
    [self initSearchBarUI];
}

- (void)initTableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 44 - 20)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setContentOffset:CGPointMake(0, 44)]; // hide UISearchBar.
    
    [self.view addSubview:_tableView];
}

- (void)initSearchBarUI {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchBar.delegate = self;
//    _searchBar.text = @"上海";
    _searchBar.backgroundColor = [UIColor clearColor];
    for (UIView *subview in _searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            
            continue;
        }
    }
    
    UIImage *searchBarBackground = [UIImage imageNamed:@"SearchBarBackground"];
    UIImageView *searchBarBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBarBackgroundView.image = searchBarBackground;
    [_searchBar insertSubview:searchBarBackgroundView atIndex:0];
    self.tableView.tableHeaderView = _searchBar;
    
    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchController.delegate = self;
    _searchController.searchResultsDataSource = self;
    _searchController.searchResultsDelegate = self;
    //    _searchController.active = YES;
    [_searchController.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [[[self fetchedResultsControllerWithTableView:tableView] sections] count];
     
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    NSFetchedResultsController *fetchController = [self fetchedResultsControllerWithTableView:tableView];
    NSArray *sections = fetchController.sections;
    if(sections.count > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
        
    return numberOfRows;
}

- (NSFetchedResultsController *)fetchedResultsControllerWithTableView:(UITableView *)tableView {
    return tableView == self.tableView ? self.fetchedResultsController : self.searchFetchedResultsController;
}

- (void)fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController configureCell:(HistoryCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    History *entity = (History *)[fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.lbCity.text = entity.city;
    cell.lbPreTaxIncome.text = [FormatUtils formatCurrency:[entity.preTaxIncome doubleValue]];
    cell.lbAfterTaxIncome.text = [FormatUtils formatCurrency:[entity.afterTaxIncome doubleValue]];
    cell.lbTax.text = [FormatUtils formatCurrency:[entity.tax doubleValue]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"HistoryCell";
    HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [self fetchedResultsController:[self fetchedResultsControllerWithTableView:tableView] configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.backgroundColor = (indexPath.row % 2) ? RGB(241, 241, 241) : RGB(247, 247, 247);
//} 

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView == self.tableView ? YES : NO;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView setEditing:YES animated:YES];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {    
    [self.tableView setEditing:NO animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //            abort();
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    UITableView *tableView = controller == self.fetchedResultsController ? self.tableView : self.searchDisplayController.searchResultsTableView;
    
    [tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    UITableView *tableView = controller == self.fetchedResultsController ? self.tableView : self.searchDisplayController.searchResultsTableView;
        
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = controller == self.fetchedResultsController ? self.tableView : self.searchDisplayController.searchResultsTableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self fetchedResultsController:controller configureCell:(HistoryCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    UITableView *tableView = controller == self.fetchedResultsController ? self.tableView : self.searchDisplayController.searchResultsTableView;
    [tableView endUpdates];
}

- (NSFetchedResultsController *)fetchedResultsControllerWithSearchString:(NSString *)searchString {
    NSPredicate *filterPredicate = nil/*[NSPredicate predicateWithFormat:@"city.length > 0"]*/;
    if(searchString.length) {
        NSMutableArray *predicateArray = [NSMutableArray array];
        [predicateArray addObject:[NSPredicate predicateWithFormat:@"city CONTAINS[cd] %@", searchString]];
        
        if(filterPredicate) {
            filterPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:filterPredicate, [NSCompoundPredicate orPredicateWithSubpredicates:predicateArray], nil]];
        } else {
            filterPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicateArray];
        }
    }
    
//    NSLog(@"%@", filterPredicate.debugDescription);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:filterPredicate];
    [fetchRequest setEntity:[NSEntityDescription entityForName:kCoreDataEntity_History inManagedObjectContext:managedObjectContext]];
    [fetchRequest setFetchBatchSize:20];    
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"createTime" ascending:NO]]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil /*kCoreDataEntity_History*/];
    aFetchedResultsController.delegate = self;
        
	NSError *error = nil;
	if (![aFetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //	    abort();
	}
    
    return aFetchedResultsController;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }

    _fetchedResultsController = [self fetchedResultsControllerWithSearchString:nil];

    return _fetchedResultsController;
}

- (NSFetchedResultsController *)searchFetchedResultsController {
    if (_searchFetchedResultsController != nil) {
        return _searchFetchedResultsController;
    }
    
    _searchFetchedResultsController = [self fetchedResultsControllerWithSearchString:_searchBar.text];
    
    return _searchFetchedResultsController;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {            
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller willUnloadSearchResultsTableView:(UITableView *)tableView {
    if (_searchFetchedResultsController) {
        self.searchFetchedResultsController.delegate = nil;
        self.searchFetchedResultsController = nil;
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:_searchBar.text scope:_searchBar.selectedScopeButtonIndex];
        
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:_searchBar.selectedScopeButtonIndex];
    
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSInteger)scope {    
    self.searchFetchedResultsController.delegate = nil;
    self.searchFetchedResultsController = nil;
}

- (void)editHistory {
//    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    for (HistoryCell *cell in self.tableView.visibleCells) {
//        NSIndexPath * indexPath = [(UITableView *)cell.superview indexPathForCell:cell];
//        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
//    }
//    
//    [appDelegate saveContext];
    
    
    if (_tableView.isEditing) {
        [_tableView setEditing:NO animated:YES];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editHistory)];
    } else {
        [_tableView setEditing:YES animated:YES];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(editHistory)];
    }
}

- (void)didReceiveMemoryWarning {
    self.searchBar = nil;
    self.searchController = nil;
    
    appDelegate = nil;
    managedObjectContext = nil;
    self.fetchedResultsController = nil;
    self.searchFetchedResultsController = nil;    
}
    
@end
