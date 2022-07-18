df <- df_combined |>
  select(identifier, in_obis) |>
  mutate(in_obis = recode(in_obis,
    `I don't know if the biological data collected by the network is included in OBIS` = NA_character_,
    `No; none of the biological data collected by the network is included in OBIS` = "no",
    `Yes; less than half of the biological data collected by the network is included in OBIS` = "some",
    `Yes; all of the biological data collected by the network is included in OBIS` = "all",
    `Yes; more than half but not all of the biological data collected by the network is included in OBIS` = "some"
  )) |>
  mutate(in_obis = ifelse(is.na(in_obis), "null", paste0("'", in_obis, "'")))

paste0("update layers_layer set data_in_obis = ", df$in_obis, " where name = '", df$identifier,"';")
