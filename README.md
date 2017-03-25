在做完edit及update后， 点击编辑，报错如下

Showing /Users/liutao/film/app/views/movies/edit.html.erb where line #4 raised:
“First argument in form cannot contain nil or be empty”

<h2>编辑电影🎬</h2>
<hr>
<%= form_for @movie do |f| %>

影片名
<%= f.text_field :title %>
