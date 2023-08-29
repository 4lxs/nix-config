return {
  s("#header", fmt([[
  #ifndef {a}
  #define {a}

  {}

  #endif // {a}
  ]], {
      i(0, "// stuff"),
      a = i(1, "header"),
  }, { repeat_duplicates = true, } )),
}, {

}
