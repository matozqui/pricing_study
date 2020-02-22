
context('Import process ok')
test_that("Rows imported", expect_true(nrow(data)>1000))
test_that("Columns imported", expect_true(ncol(data)>5))
test_that("Type cm_name", expect_is(data$cm_name,'character'))
