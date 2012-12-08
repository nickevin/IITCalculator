//
//  HistoryController.h
//  IITCalculator
//
//  Created by Kevin Nick on 2012-9-30.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, NSFetchedResultsControllerDelegate>

// outlets
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchDisplayController *searchController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *searchFetchedResultsController;

@end
