/^[A-Z_]+=/ {
  gsub(/\$1/,"'"target"'")
  print
}
