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

test_that("validateOSD handles empty files safely", {
  tf <- tempfile(fileext = ".txt")
  on.exit(unlink(c(tf, "empty_test.log")), add = TRUE)

  # completely empty file
  file.create(tf)
  expect_false(validateOSD("empty_test.log", tf))

  # file with only whitespace and empty lines
  writeLines(c("   ", "", "\t", "  \n "), tf)
  expect_false(validateOSD("empty_test.log", tf))

  # osd_to_json handles empty file in file list gracefully
  res <- osd_to_json(logfile = "empty_test.log", osd_files = tf, output_dir = tempdir())
  expect_false(unname(res[1]))
})

