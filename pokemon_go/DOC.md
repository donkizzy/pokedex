# pokedex

A Pokedex Flutter app


## Getting Started

After cloning the repo you can run the app using the following commands

```
cd  pokemon_go
pub get
flutter run
```
![App](https://user-images.githubusercontent.com/23106276/142911320-ea8081b5-78b7-4514-93da-65f6ef2b8d5d.gif)
## Implementation

I implemented using the latest flutter version null safety support it fetches pokemons from https://pokeapi.co and allows users save their favourites ones on their device in an efficient manner
such that reading and writing isn't an hassle and it is readily available

it also has an intuitive UI that is designed to fit different screen sizes 

## Libraries Used
- [Cached Network Image](https://pub.dev/packages/cached_network_image) : This package helps with caching images on the devices of the Usr and saves them memory as they do not need to fetch if it has already been cached
- [Dio](https://pub.dev/packages/dio) : This package helps with making http requests and makes error handling for requests a breeze
- [Equatable](https://pub.dev/packages/equatable) : Equatable overrides == and hashCode for you so you don't have to waste your time writing lots of boilerplate code.
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc) : Flutter Bloc is a State management package that helps build fast and reactive applications 
- [Flutter Lint](https://pub.dev/packages/flutter_lints) : Flutter Lints is a linting package that contains all the flutter recommended best practices to ensure quality coding practices
- [Shimmer](https://pub.dev/packages/shimmer) : Shimmer is a skeleton loader package that helps make Intuitive loaders
- [Palette Generator](https://pub.dev/packages/palette_generator) : These package helps with extracting colours from images this package helped with determining the background color for pokemons 
- [Hive](https://pub.dev/packages/hive_flutter) : These package helps with making saving information on devices easy i chose it because the data been stored doesn't require any complex relationship as it is simple app
- [Lazy Load Scrollview](https://pub.dev/packages/lazy_load_scrollview) : These package helps paginations and allows ou set how far to the end of the list do you want to make another request

##Do a critique: 
The current implementation isn't perfect he current implementation isn't perfect. How could it be improved? 
- Currently getting the pokemons isn't quite efficient as  the performing heavy operations(like getting the images dominant colors) , loops and getting the individual pokemons details. 
  
  This could be resolved by individually fetching pokemon's data and displaying available informations while the remaining information is been fetched in the background so that the users doesn't wait too 
  long to see result and if a request fails it is easy to retr that particular request
  i was unable to implement this approach due to time constraint