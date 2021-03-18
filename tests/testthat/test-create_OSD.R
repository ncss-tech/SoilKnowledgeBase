test_that("osd_to_json works", {
  # set pseudorandom seed for consistently random results
  set.seed(123)

  # sample without replacement -- 1000 OSDs
  testfiles <- sort(sample(na.omit(list.files("./OSD",
                             recursive = TRUE,
                             full.names = TRUE)),
                      size = 1000))

  # skip if files do not exist
  skip_if_not(length(testfiles) > 0)

  # expect they all run without error (does not validate contents)
  expect_true(all(unlist(osd_to_json(logfile = "test.log", osd_files = testfiles))))
})
