## -----------------------------------------------------------------------------
courses <-       c("A","B","C","D","E","F","G","H","I")
prerequisites <- c(" "," "," ","A","C"," ","D","F","D")
corequisites <-  c(" ","A"," "," "," "," "," "," ","H")

## -----------------------------------------------------------------------------
terms <- c(1,1,1,2,2,2,3,3,3)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(CurricularComplexity)

## -----------------------------------------------------------------------------
example_plan_of_study <- create_plan_of_study(Course = courses,
                                              Prereq = prerequisites,
                                              Coreq = corequisites,
                                              Term = terms)

## -----------------------------------------------------------------------------
plot_plan_of_study(example_plan_of_study)

## -----------------------------------------------------------------------------
admissibility_test(example_plan_of_study)

## -----------------------------------------------------------------------------
courses <-       c("A","B","C","D","E","F","G","H","I")
prerequisites <- c(" "," "," ","A","C","E","D","F","D") 
corequisites <-  c("B","A"," "," "," ","I"," "," ","H") 
#E is a prereq for F in same semester
#A and B are mutually coreqed, F has coreq I in diff semesters

error_plan_of_study <- create_plan_of_study(Course = courses,
                                              Prereq = prerequisites,
                                              Coreq = corequisites,
                                              Term = terms)

admissibility_test(error_plan_of_study)

## -----------------------------------------------------------------------------
plot_plan_of_study(error_plan_of_study)

## -----------------------------------------------------------------------------
courses <-       c("A","B","C","D","E","F","SenStand","G","H",         "I")
prerequisites <- c(" "," "," ","A","C"," "," ",       "D","F,SenStand","D,SenStand")
corequisites <-  c(" ","A"," "," "," "," "," ",       " "," ",         "H")
terms <-         c(1,   1,  1,  2,  2,  2,  2,         3,  3,           3)
example_plan_of_study_sen_standing <- create_plan_of_study(Course = courses,
                                                           Prereq = prerequisites,
                                                           Coreq = corequisites,
                                                           Term = terms)
plot_plan_of_study(example_plan_of_study_sen_standing)

## -----------------------------------------------------------------------------
example_requisites <- c("(A+B),(C+D)",
                        "MINGRADE(A)[C-]+(MINGRADE(B)[D],MINGRADE(C)[D])",
                        "FROM(A,B,C)[2]"
                        )
simplify_requisites(example_requisites)

## -----------------------------------------------------------------------------
courses <-       c("A","B","C","D","E","F","G","H","I","Elec","Elec")
prerequisites <- c(" "," "," ","A","C"," ","D","F","D"," ",   " ")
corequisites <-  c(" ","A"," "," "," "," ",","," ","H"," ",   " ")
terms <-         c(1,   1,  1,  2,  2,  2,  3,  3,  3,  3 ,    3)
example_plan_of_study_elec <- create_plan_of_study(Course = courses,
                                                   Prereq = prerequisites,
                                                   Coreq = corequisites,
                                                   Term = terms)
plot_plan_of_study(example_plan_of_study_elec)

## -----------------------------------------------------------------------------
courses <-       c("A","B","C","D","E","F","G","H","I","Elec 1","Elec 2")
prerequisites <- c(" "," "," ","A","C"," ","D","F","D","E,F", "C")
corequisites <-  c(" ","A"," "," "," "," ",","," ","H"," ",   " ")
terms <-         c(1,   1,  1,  2,  2,  2,  3,  3,  3,  3 ,    3)
example_plan_of_study_elec <- create_plan_of_study(Course = courses,
                                                   Prereq = prerequisites,
                                                   Coreq = corequisites,
                                                   Term = terms)
plot_plan_of_study(example_plan_of_study_elec)

## -----------------------------------------------------------------------------
blocking_factor(example_plan_of_study,"A")

## -----------------------------------------------------------------------------
blocking_factor(example_plan_of_study,"A", include_coreqs = FALSE)

## -----------------------------------------------------------------------------
delay_factor(example_plan_of_study,"A")

## -----------------------------------------------------------------------------
delay_factor(example_plan_of_study,"A",include_coreqs = FALSE)

## -----------------------------------------------------------------------------
blocking_factor(example_plan_of_study,"A")+delay_factor(example_plan_of_study,"A")

## -----------------------------------------------------------------------------
cruciality(example_plan_of_study,"A")
cruciality(example_plan_of_study,"A") == blocking_factor(example_plan_of_study,"A")+delay_factor(example_plan_of_study,"A")

## -----------------------------------------------------------------------------
cruciality(example_plan_of_study,"A", include_coreqs = FALSE)

## -----------------------------------------------------------------------------
example_structural_complexity <- structural_complexity(example_plan_of_study)
#The individual outputs can be selected like so...
example_structural_complexity$`Course Crucialities`

## -----------------------------------------------------------------------------
example_structural_complexity$`Overall Structural Complexity`

## -----------------------------------------------------------------------------
example_structural_complexity <- structural_complexity(example_plan_of_study, term_weighted = TRUE)
#The individual outputs can be selected like so...
example_structural_complexity$`Course Crucialities`

## -----------------------------------------------------------------------------
example_structural_complexity <- structural_complexity(example_plan_of_study, quarters = TRUE)
example_structural_complexity$`Course Crucialities`
example_structural_complexity$`Overall Structural Complexity`

## -----------------------------------------------------------------------------
courses_related_to_A <- subcomplexity_graph(example_plan_of_study, "A")
plot_plan_of_study(courses_related_to_A)

## -----------------------------------------------------------------------------
example_structural_complexity_for_subgraph <- structural_complexity(courses_related_to_A)
#The individual outputs can be selected like so...
example_structural_complexity_for_subgraph$`Course Crucialities`

## -----------------------------------------------------------------------------
example_core_collapse <- core_collapse(example_plan_of_study)

## -----------------------------------------------------------------------------
example_core_collapse$sequence

## -----------------------------------------------------------------------------
kcores <- example_core_collapse$kcores
plot_plan_of_study(kcores[[1]])
plot_plan_of_study(kcores[[2]])
plot_plan_of_study(kcores[[3]])

## -----------------------------------------------------------------------------
deferment_factor(example_plan_of_study,"A",3)

## -----------------------------------------------------------------------------
deferment_factor(example_plan_of_study,"B",3)

## -----------------------------------------------------------------------------
find_bottlenecks(example_plan_of_study,min_prereq = 3, min_postreq = 3, min_connections = 5,include_coreqs = TRUE)

## -----------------------------------------------------------------------------
find_bottlenecks(example_plan_of_study)

## -----------------------------------------------------------------------------
find_bottlenecks(example_plan_of_study,min_prereq = 2, min_postreq = 2, min_connections = 3,include_coreqs = TRUE)

## -----------------------------------------------------------------------------
find_bottlenecks(example_plan_of_study,min_prereq = 2, min_postreq = 2, min_connections = 1,include_coreqs = TRUE)

## -----------------------------------------------------------------------------
reachability_factor(example_plan_of_study,"G")

## -----------------------------------------------------------------------------
reachability_factor(example_plan_of_study,"G", include_coreqs = FALSE)

## -----------------------------------------------------------------------------
curriculum_rigidity(example_plan_of_study)

## -----------------------------------------------------------------------------
transfer_delay_factor(example_plan_of_study,2)

## -----------------------------------------------------------------------------
courses_extending_time <- transfer_excess_courses(example_plan_of_study,2)
plot_plan_of_study(courses_extending_time)

## -----------------------------------------------------------------------------
#Only supplying the plan of study object will return the average length of the prerequisite chains for the entire plan of study.
average_sequencing(example_plan_of_study)
#Adding the expected time to degree will only calculated the average for the courses extending the time to degree.
average_sequencing(example_plan_of_study, expected_time_to_degree = 2)

## -----------------------------------------------------------------------------
explained_complexity(example_plan_of_study,2)

## -----------------------------------------------------------------------------
courses <-       c("A","B","C","D","E","F","G","H","I")
prerequisites <- c(" "," "," ","A","C"," ","D","F","D")
corequisites <-  c(" ","A"," "," "," "," "," "," ","H")
terms <- c(1,1,1,2,2,2,3,3,3)

#Now we'll incorporate the timing here:
timing <- c("Fall",NA,NA,"Alt Spring",NA,NA,"Alt Fall",NA,"Spring")

example_plan_of_study <- create_plan_of_study(Course = courses,
                                              Prereq = prerequisites,
                                              Coreq = corequisites,
                                              Term = terms,
                                              Timing = timing)

## -----------------------------------------------------------------------------
inflexibility_factor_result <- inflexibility_factor(example_plan_of_study,2)
inflexibility_factor_result$`Inflexibility Factors`
inflexibility_factor_result$Total

