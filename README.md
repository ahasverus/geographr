# geographr

An R package to have fun with geography.

## Installation

You can install this package from Github:

```r
### First install the devtools package (if not already installed)
install.packages('devtools')
library(devtools)

### Then install the geographr package
devtools::install_github('ahasverus/geographr')

### And load the package
library(geographr)
```

## Documentation

The `geographr` package contains four main functions.

##### Learn about countries geography and flag

```r
learn_country(region = 'world')
learn_country(region = 'south america')
```

![Screenshot](./example1.png)

##### Try to identify country on map

```r
where_is(region = 'africa')
where_is(region = 'europa', lang = 'fr')
```

![Screenshot](./example2.png)

##### Try to find country from its flag

```r
what_flag(region = 'world')
what_flag(region = 'asia', lang = 'en')
```

##### Try to locate cities on map

```r
by_cities(country = 'france', n = 10)
```

## License

This package is licensed to you under the terms of the [GNU General Public
License](http://www.gnu.org/licenses/gpl.html) version 3 or later.
