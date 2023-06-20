Sys.setlocale('LC_ALL' , 'ko_KR.UTF-8')
par(family = 'D2Coding')
theme_set(theme_grey(base_family='D2Coding'))

library(foreign)
library(dplyr)
library(tidyr)
library(magrittr)
library(ggplot2)
library(readxl)
library(haven)
library(stringr)
library(forcats)

birthmarry = read_excel("./midterm.xlsx", sheet = "출산및혼인")
avgage = read_excel("./midterm.xlsx", sheet = "모나이평균")
grpage = read_excel("./midterm.xlsx", sheet = "모나이그룹")

#1 
birthmarry %>%
  filter(ITM_NM == "합계출산율" & C1 == "00") %>%
  group_by(PRD_DE) %>%
  ggplot(aes(x = PRD_DE, y = as.double(DT), group = 1)) +
  geom_line() +
  geom_hline(yintercept = 1, color = "red") +
  ylab("DT")

#2
birthmarry %>%
  filter(C1 != "00" & C1 != "90" & PRD_DE == "2022") %>%
  group_by(C1_NM) %>%
  ggplot(aes(x = fct_reorder(C1_NM, DT), y = as.double(DT))) +
  geom_col() + 
  coord_flip() +
  xlab("시도") +
  ylab("출생률")

#3
birthmarry %>%
  filter(C1 != "00" & C1 != "90" & ITM_ID == "T41") %>%
  group_by(PRD_DE) %>%
  ggplot(aes(x = PRD_DE, y = as.double(DT), group = 1)) +
  geom_line() +
  facet_wrap(. ~ C1_NM, ncol = 5) +
  ylab("DT")

#4
avgage %>%
  ggplot(aes(x = PRD_DE, y = as.double(DT), group = 1)) +
  geom_line() +
  geom_point() +
  ylab("DT")

#5
grpage %>%
  group_by(C2_NM, C3_NM, PRD_DE, DT) %>%
  select(C2_NM, C3_NM, PRD_DE, DT) %>%
  pivot_wider(names_from = PRD_DE, values_from = DT)

#6
grpage %>%
  select(C2_NM, C3_NM, PRD_DE, DT) %>%
  filter(C2_NM == "계" & C3_NM != "총계") %>%
  group_by(PRD_DE) %>%
  mutate(ratio = as.integer(DT) / sum(as.integer(DT))) %>%
  ggplot(aes(x = PRD_DE, y = ratio, group = C3_NM, color = C3_NM)) +
  geom_line() +
  geom_point()