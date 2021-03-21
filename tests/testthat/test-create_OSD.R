test_that("osd_to_json works", {
  # setwd("~/workspace/SoilKnowledgeBase/tests/testthat")

  # set pseudorandom seed for consistently random results
  set.seed(123)

  # list OSD .txt files
  testfiles <- na.omit(list.files("OSD",
                             recursive = TRUE,
                             full.names = TRUE))

  # skip if files do not exist
  skip_if_not(length(testfiles) > 0)

  # testfiles <- sort(sample(testfiles, size = 1000))

  osd_result <- osd_to_json(logfile = "test.log",
                            osd_files = testfiles)

  # expect they all run without error (does not validate contents)
  expect_true(all(unlist(osd_result)))
})
