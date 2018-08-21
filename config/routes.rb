Rails.application.routes.draw do
  
devise_for :users
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'posts#index'
get '/posts/index' => 'posts#index'
get '/posts/about' => 'posts#about'
get '/posts/all' => 'posts#all'
get '/posts/mypage' => 'posts#mypage'

post '/posts/:post_id/questions/create' => 'posts#questioncreate'
get "/posts/:post_id/questions/:question_id/destroy" => 'posts#questiondestroy'
get "/posts/:post_id/questions/:question_id/edit" => 'posts#questionedit'
post "/posts/:post_id/questions/:question_id/update" => 'posts#questionupdate'
get "/posts/:post_id_for_you/answer/new" => 'posts#answernew'
post '/posts/:post_id_for_you/answer/create' => 'posts#answercreate'
get '/posts/:post_id/result' => "posts#result"
post "/posts/:post_id/questions/:question_id/selections/create" => "posts#selectioncreate"
get "/posts/:post_id/questions/:question_id/selections/:selection_id/destroy" => 'posts#selectiondestroy'
get '/posts/:post_id/questions/:question_id/chart_change' => 'posts#chart_change'

post '/posts/search' => 'posts#search'
# index, all, about link should be added


resources :posts
end
