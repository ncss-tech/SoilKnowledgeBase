context("Refreshing from external data sources")

test_that("refresh (no source PDF download)", {
  pdf_path <- file.path(find.package("SoilKnowledgeBase"), "NSSH", "pdf")
  pdfs <- list.files(pdf_path, pattern = "pdf", recursive = TRUE, full.names = TRUE)
  skip_if(length(pdfs) == 0)
  res <- refresh(download_pdf = FALSE, keep_pdf = TRUE)
  expect_true(all(unlist(res)))
  unlink("inst", recursive = TRUE)
})

test_that("refresh (from source; poppler-utils required)", {

  skip_if_not(Sys.info()['sysname'] == 'Linux')
  skip_if_not(system("dpkg --list | grep poppler-utils") == 0)

  res <- refresh(keep_pdf = TRUE)
  res_test <- unlist(res)

  # more informative output about which if any failed
  if (any(!res_test))
    print(res_test)

  expect_true(all(res_test))
  unlink("inst", recursive = TRUE)
})
