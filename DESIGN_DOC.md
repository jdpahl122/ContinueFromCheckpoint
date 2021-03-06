# Design Document

The goal of the site is to let users track their game library, progress completing games, time played, scores for games, etc.

## Similar works

Existing game tracking sites:

- [Backloggery](http://backloggery.com/)
- [Completionator](https://www.completionator.com/Game?platformIDs=53&sortColumn=GameName&sortDirection=ASC)

Similar tracking sites for movies/television/anime:

- [MyAnimeList](https://myanimelist.net/)
- [AniList](https://anilist.co/)
- [Kitsu](https://kitsu.io)
- [IMDb](https://www.imdb.com/)

## TODO

- [ ] Users
  - [x] Authentication with Devise
  - [ ] 2FA (via devise-two-factor probably)
  - [x] Username
  - [ ] Display Name
  - [ ] Avatar
  - [ ] External account links (Discord, Steam, Epic Games, Xbox Live, PSN, etc.)
  - [ ] Users have a Game Library which contains Games
  - [ ] Users have a profile
- [ ] Profiles
  - [ ] Profiles can be Public or Private (only visible to Friends/Yourself? Username, Display Name, and Avatar will always be visible.)
  - [x] Bio (a longer-form description of the user)
  - [ ] Game Library with scores, completion status, time played, etc.
    - Should there be more granular access options, e.g. hiding time played?
    - Should the user that owns the profile be able to choose what's visible by default in their profile's Library list?
- [ ] Friends (or followers/following?)
  - [ ] Activity feed?
- [ ] Game Library
  - [ ] A "plan-to-play" list (different from a Wishlist?)
  - [ ] Steam Importer (connect your Steam account and import/sync all the game data from it)
    - Should be able to sync with Steam after you've imported your games.
    - How to handle duplication, e.g. if I add my games and _then_ use the Steam importer?
    - Should also support importing from other platforms, but I don't know how many even have APIs for this.
  - [ ] Score (like AniList's multi-score-system system? e.g. have 1/10, 1.0/10, 10/100, and thumbs-up/thumbs-down)
- [ ] Games (General): Games are an entity with a name, platforms, developers, publishers, a cover image, release dates, etc.
  - [x] Name
  - [x] Platform(s) (Windows, macOS, Linux, Nintendo Switch, Xbox 360, etc.)
    - Should games have separate entries for each platform (e.g. Team Fortress 2 on Windows is very different from Team Fortress 2 on Xbox 360)?
    - Should this differentiate between, e.g. Steam vs. Discord vs. Epic, etc?
  - [x] Developer (can have more than one)
  - [x] Publisher (can have more than one?)
  - [ ] Cover image
  - [ ] Release date(s) (note that a game can have more than one release date due to platform differences or due to regional differences)
  - [ ] External Links (Steam page, Discord store page, Discord server, PCGamingWiki, SteamDB, etc.)
  - [ ] Relationships with other games (sequels, prequels, spinoffs, DLC, Special Editions, GOTY/Complete Editions, Remakes, Deluxe Editions, "sibling"(?) titles (e.g. Pokemon Red and Blue), etc?)
  - [ ] Official Website
    - Note there can be more than one, e.g. for multiple languages.
  - [x] Genre
    - I don't look forward to figuring out how to manage genres, but it seems kind of necessary.
  - [ ] Average Score
    - Maybe also Median or a more detailed bar graph of the scores?
  - [ ] Number of users who own the game / have completed it / plan to play it
- [x] Companies
  - Companies can both develop and publish games.
  - [x] Developers
  - [x] Publishers
- [ ] Release Purchase: A release in someone's library can be rated, can have time played, platforms upon which it's owned, etc. It is essentially a subclass of Games (General).
  - [ ] Score/Rating
  - [ ] Time played (hours)
  - [ ] Platform
  - [ ] Owned
    - Boolean? This is complicated by the fact that you can own a game on multiple platforms.
    - What about previously-owned?
  - [ ] Completion Status
     - Unplayed, In-Progress, Dropped, Completed
     - Should there be a status like `Completed (100%)`? I can see that being useful, but it also feels unnecessarily complicated.
     - Some games can't be completed (e.g. Overwatch, Counter-Strike, etc.), should that have a specific status?
     - What about games that are in development, like Early Access games?
     - Also worth noting that you can rent or borrow games, so you may not own them but _have_ completed them.
     - Maybe also have Completed*, which is "Essentially Completed" for games where you didn't _quite_ complete it, but you feel you're finished with it?
  - [ ] Start Date / Completion Date
  - [ ] Notes (any notes you want to add about the game, essentially a mini review)
  - [ ] Replayed (A counter for the number of times you've replayed a game)
  - [ ] Favorite (you can favorite games in your library, which is tracked separately from your Score)
  - [ ] Physical/Digital
    - I'm really not sure how to handle this, theoretically you can own a game for Switch digitally as well as physically.
- [ ] Exporter (export your games list, probably as JSON, _maybe_ as a CSV?)
- [ ] Build the initial system for importing game information from another source (build the game database from the GiantBomb Wiki? Wikipedia/Wikidata? PCGamingWiki? A combination of these? Somewhere else?)
- [ ] API?
- [ ] Game creation / modification
  - AniList has a concept of "moderators" that can update information on anime, e.g. adding missing genres or tags, changing the release date when it's delayed, etc.
  - We'll need some way for the user to create a game when a new one comes out.
  - Uploading cover art is another sticking point, since we'll need to host those images (not easy on Heroku).

Some decisions that need to be made:

- Should scores work like AniList's multiple-score-types system? e.g. have 1/10, 1.0/10, 10/100, and thumbs-up/thumbs-down, you can theoretically represent all of those integer values of 1-100, but converting between some formats to others can be "lossy", though it doesn't _have_ to be.
- Should there be an API? If so, should it be a REST API or use GraphQL?
- Should games have separate entries for each platform (e.g. Team Fortress 2 on Windows is very different from Team Fortress 2 on Xbox 360)?
- Should this differentiate between, e.g. Steam vs. Discord vs. Epic, etc?
- How to handle completion statuses, especially for games that are multiplayer with no real "win state", e.g. Counter-Strike or Overwatch. 
