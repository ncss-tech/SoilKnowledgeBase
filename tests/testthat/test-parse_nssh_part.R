test_that("parsing headers works", {
  st <- parse_nssh_structure(download_pdf = FALSE,
                             keep_pdf = TRUE)
  expect_silent(parse_nssh_part(st$part, st$subpart))
})
