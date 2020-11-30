test_that("parsing headers works", {
  st <- parse_nssh_structure()
  expect_silent(parse_nssh_part(st$part, st$subpart))
})
