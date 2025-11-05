
list.files(recursive = TRUE, pattern = "\\.(qmd|md|Rmd)$",
           full.names = TRUE) |>
  rlang::set_names() |>
  purrr::map(\(x) {
    cont <- readLines(con = x)
    urls1 <- stringr::str_extract_all(string = cont,
                                      pattern = "(?<=<).*?(?=>)") |>
      unlist() |>
      unique()
    urls2 <- stringr::str_extract_all(string = cont,
                                      pattern = "(?<=]\\().*?(?=\\))") |>
      unlist() |>
      unique()
    urls <- c(urls1, urls2) |>
      unique()
    RCurl::url.exists(urls) |>
      purrr::keep(\(x) !x) |>
      names()
  })
