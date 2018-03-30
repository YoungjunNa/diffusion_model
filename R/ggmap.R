pacman::p_load("ggmap","tidyverse")

seoul <- enc2utf8("서울") %>%
  geocode() %>%
  as.numeric() %>%
  get_googlemap(maptype="roadmap",zoom=12) %>%
  ggmap()

