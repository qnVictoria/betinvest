-module (p06).
-export ([is_palindrome/1]).

is_palindrome(List) ->
  List == p05:reverse(List).
