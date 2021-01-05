test_that("osd_to_json works", {
  testfiles <- na.omit(list.files("./OSD/A",
                             recursive = TRUE,
                             full.names = TRUE)[1:100])
  skip_if_not(length(testfiles) > 0)
  expect_true(all(unlist(osd_to_json(osd_files = testfiles))))
})
