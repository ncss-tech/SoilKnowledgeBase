test_that("create_nssh_index with no PDF download", {
  expect_silent(create_nssh_index(download_pdf = FALSE,
                                  keep_pdf = TRUE))
  unlink("inst", recursive = TRUE)
})
