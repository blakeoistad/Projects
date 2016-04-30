//
//  Episode+CoreDataProperties.h
//  jrxOBJC
//
//  Created by Blake Oistad on 4/30/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Episode.h"

NS_ASSUME_NONNULL_BEGIN

@interface Episode (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *episodeTitle;
@property (nullable, nonatomic, retain) NSString *episodeGuests;
@property (nullable, nonatomic, retain) NSDate   *episodeReleaseDate;
@property (nullable, nonatomic, retain) NSString *episodeAudioURL;
@property (nullable, nonatomic, retain) NSString *episodeDescription;
@property (nullable, nonatomic, retain) NSString *episodeImageURL;
@property (nullable, nonatomic, retain) NSString *episodeKeywords;
@property (nullable, nonatomic, retain) NSString *episodeState;
@property (nullable, nonatomic, retain) NSNumber *episodeTrackPlace;

@end

NS_ASSUME_NONNULL_END
