class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # セッション用ヘルパーモジュールを読み込む
  include SessionsHelper

  def hello
    render html: "hello, wold!"
  end
  
end
