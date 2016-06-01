# geographr

An R package to have fun with geography.

## Installation

You can install this package from Github:

```r
### First install the devtools package
install.packages('devtools')
library(devtools)

### Then install the geographr package
devtools::install_github('ahasverus/geographr')
```

## Documentation

1. Learn about countries geography and flag:

```r
learn_country()
```

2. Try to locate countries on map

```r
where_is(region = 'africa')
where_is(region = 'europa', lang = 'fr')
```

3.

## License

This package is licensed to you under the terms of the [GNU General Public
License](http://www.gnu.org/licenses/gpl.html) version 3 or later.
