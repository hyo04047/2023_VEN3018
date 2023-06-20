library(rvest)
library(httr)

url = 'https://movie.daum.net/ranking/reservation'

movie = GET(url)

movie_html = read_html(movie)
제목 = movie_html %>%
  html_nodes('div.thumb_cont') %>%
  html_nodes('a.link_txt') %>%
  html_text()
평점 = movie_html %>%
  html_nodes('div.thumb_cont') %>%
  html_nodes('span.info_txt') %>%
  html_nodes('span.txt_grade') %>%
  html_text()
예매율 = movie_html %>%
  html_nodes('div.thumb_cont') %>%
  html_nodes('span.info_txt') %>%
  html_nodes('span.txt_num') %>%
  html_text()
개봉 = movie_html %>%
  html_nodes('div.thumb_cont') %>%
  html_nodes('span.txt_info') %>%
  html_nodes('span.txt_num') %>%
  html_text()

movie_result = data.frame()
movie_result = rbind(movie_result, data.frame(제목, 평점, 예매율, 개봉))

print(movie_result)