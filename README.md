
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dataset

<!-- badges: start -->

<!-- badges: end -->

`dataset` 패키지는 LG 인화원의 교육을 위해서 작성한 데이터 패키지입니다.

## 설치

`dataset` 패키지는 아래 코드를 이용해 설치할 수 있습니다. `remotes` 패키지는 설치되어 있지 않다면 설치해야
`github`내의 패키지를 설치할 수 있습니다.

``` r
install.packages("remotes")
remotes::install_github("lgleadershipacademy/dataset")
```

## 사용할 수 있는 데이터 리스트

``` r
library(dataset)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
list_of_dataset()
#>  [1] "avocado"      "churn"        "emp_tmnt"     "emp_attr"    
#>  [5] "mall"         "credit_train" "credit_test"  "games"       
#>  [9] "retail"       "mining"       "prod_line"
```
