; extends

(macro_invocation
 (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query"))

 (token_tree
   (raw_string_literal) @sql) 
   (#offset! @sql 1 0 0 0))

((line_comment) @_first 
 (_) @rust
 (line_comment) @_last 
 (#match? @_first "^/// ```$") 
 (#match? @_last "^/// ```$")
 (#offset! @rust 0 4 0 4))
