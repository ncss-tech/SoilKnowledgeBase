test_that("parse_nssh_structure with default settings", {
  expect_silent(parse_nssh_structure(download_pdf = FALSE,
                                     keep_pdf = TRUE))
  unlink("inst", recursive = TRUE)
})
