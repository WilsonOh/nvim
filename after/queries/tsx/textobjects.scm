; extends
;; (jsx_element
;;   open_tag: (jsx_opening_element
;;               attribute: (jsx_attribute) @jsx_attribute.outer))
(jsx_attribute) @jsx_attribute.outer

[
 (jsx_element)
 (jsx_self_closing_element)
] @tag.outer

(jsx_element
  open_tag: (jsx_opening_element)
  (_) @tag.inner
  close_tag: (jsx_closing_element))
