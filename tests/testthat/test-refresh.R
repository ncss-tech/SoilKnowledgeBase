context("Refreshing from external data sources")

test_that("refresh (no source PDF download)", {
  res <- refresh(download_pdf = FALSE, keep_pdf = TRUE)
  expect_true(all(unlist(res)))
  unlink("inst", recursive = TRUE)
})

test_that("refresh (from source; poppler-utils required)", {
  skip_if_not(suppressWarnings(system('pdftotext')) == 0)
  res <- refresh()
  expect_true(all(unlist(res)))
  unlink("inst", recursive = TRUE)
})
