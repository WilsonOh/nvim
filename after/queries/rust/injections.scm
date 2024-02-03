; extends

(macro_invocation
 (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#eq? @_name "query"))

 (token_tree
   (raw_string_literal) @injection.content
   (#set! injection.language "sql")) 
   (#offset! @injection.content 1 0 1 0))

((line_comment) @_first 
 (_) @rust
 (line_comment) @_last 
 (#match? @_first "^/// ```$") 
 (#match? @_last "^/// ```$")
 (#offset! @rust 0 4 0 4))
