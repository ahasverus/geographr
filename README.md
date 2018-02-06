# geographr

An R package to test your skills in world geography.

## Installation

You can install this package from Github.

```r
### First install the devtools package (if not already installed)
install.packages('devtools')

### Then install the geographr package
library(devtools)
devtools::install_github('ahasverus/geographr')

### And load the package
library(geographr)
```

## Documentation

The `geographr` package contains seven main functions. All of these functions are available in two different languages: english (en) and french (fr). English is the default in all the functions.



#### Refine your geographic skills

```r
#### Default settings
learning(region = 'world', lang = 'en')

#### Short version
learning()

#### User settings usage
learning(region = 'south america', lang = 'fr')
```

![Screenshot](inst/example1.png)

#### Getting the correct spelling of countries and regions

```r
#### Get the correct spelling of regions
get_region_name()
get_region_name(lang = 'fr')

#### Get the correct spelling of countries
get_country_name()
get_country_name(lang = 'fr')
```

#### Identify countries on the map

```r
#### Default settings
find_country(region = 'europa', lang = 'en')

#### Short version
find_country()

#### User settings usage
find_country(region = 'africa', lang = 'fr')
```

![Screenshot](inst/example2.png)

#### Identify national flags

```r
#### Default settings
find_flag(region = 'world', lang = 'en')

#### Short version
find_flag()

#### User settings usage
find_flag(region = 'asia', lang = 'fr')
```

![Screenshot](inst/example3.png)

#### Locate regions on the country map

```r
#### Default settings (random country)
find_region(country = NULL, lang = 'en')

#### Short version
find_region()

#### User settings usage
find_region(country = 'spain', lang = 'en')
```

![Screenshot](inst/example5.png)

#### Locate n cities on the map

```r
#### Default settings (random country)
find_cities(country = NULL, n = 10, lang = 'en')

#### Short version
find_cities()

#### User settings usage
find_cities(country = 'france', n = 10, lang = 'en')
```

![Screenshot](inst/example4.png)

More than 40,000 towns are available. For instance, one thousand are available for France. But do not overload the map with a too higher number of towns. It will be unclickable...

## Notes

The argument `lang` defines the language of the interface. But it has no impact when you search for a specific region/country: `find_cities('spain')` is the same as `find_cities('Espagne')`. Moreover search based on region and country is case-insensitive.

At the end of each function, take a look at the R console: some statistics are provided.

Cities and world shapefile come from the [maps](https://cran.r-project.org/web/packages/maps/index.html) package. High resolution shapefiles come from [GADM](http://gadm.org).

For a better visual experience, please do not resize graphical windows.

The function `find_cities()` needs more development. But it works. Enjoy!

## Acknowledgments

Special thanks to [@KevCaz](https://github.com/kevcaz) and [@SteveViss](https://github.com/SteveViss) for their feedbacks :smile:

## License

This package is licensed to you under the terms of the [GNU General Public
License](http://www.gnu.org/licenses/gpl.html) version 3 or later.
