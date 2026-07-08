#' Finds the number of terms a course can move to
#'
#' This function takes in a plan of study, a course, the expected time to degree, and a
#' logical value indicating whether to restrict the number of free terms to those later
#' in the curriculum. The value is the number of free terms that the course can move to
#' @param plan_of_study igraph object - An igraph object created using the create_plan_of_study function
#' @param course Numeric (vertex id) or String - The course to find the number of free terms for
#' @param expected_time_to_degree Numeric - The term where students are expected to finish (often 8)
#' @param outbound_only logical - TRUE if the calculation should only include courses after the course (postreqs)
#' @return Numeric - the number of free terms
#' @export

find_number_of_free_terms <- function(plan_of_study,
                                      course, 
                                      expected_time_to_degree,
                                      outbound_only)
{
  course_term <- V(plan_of_study)[course]$term
  prereqs <- find_inbound_courses(plan_of_study,course,include_coreqs = FALSE)
  prereqs_terms <- V(plan_of_study)[prereqs]$term
  postreqs <- find_outbound_courses(plan_of_study,course, include_coreqs = FALSE)
  postreqs_terms <- V(plan_of_study)[postreqs]$term
  terms_with_courses <- unique(c(course_term,prereqs_terms,postreqs_terms))
  terms_with_courses <- terms_with_courses[order(terms_with_courses)]
  term_list <- 1:expected_time_to_degree
  prereq_gaps <- term_list %in% terms_with_courses
  
  index <- expected_time_to_degree
  number_of_free_terms <- 0
  
  if (outbound_only == TRUE)
  {
    while (index >= course_term)
    {
      if(prereq_gaps[index] == FALSE)
      {
        number_of_free_terms <- number_of_free_terms + 1
      }
      index <- index - 1
    }
  }
  else
  {
    course_delay_factor <- delay_factor(plan_of_study,course)
    number_of_free_terms <- expected_time_to_degree - course_delay_factor
  }
  return(number_of_free_terms)
}




