#' Calculates the deferment factor of a course
#'
#' This function takes in a plan of study and a course, then finds that course's deferment factor.
#' The value captures the number of terms the student can fail the course before extending their time
#' to degree.
#'
#' @param plan_of_study igraph object - An igraph object created using the create_plan_of_study function
#' @param course Numeric (vertex id) or String - The course to calculate the deferment factor of
#' @param expected_time_to_degree Numeric - The term where students are expected to finish (often 8)
#' @param outbound_only logical - TRUE (by default) if the calculation should only include courses after the course (postreqs)
#' @return Numeric - the deferment factor
#' @export


deferment_factor <- function(plan_of_study, course, expected_time_to_degree,outbound_only=TRUE)
{
  terms_before_extension <- find_number_of_free_terms(plan_of_study, course, expected_time_to_degree,outbound_only)
  deferment_factor_calculation <- 1/(1+terms_before_extension)
  return(deferment_factor_calculation)
}

