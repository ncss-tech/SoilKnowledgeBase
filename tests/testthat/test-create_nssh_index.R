test_that("parse_nssh_structure with default settings", {
  expect_silent(parse_nssh_structure())
  unlink("inst", recursive = TRUE)
})
